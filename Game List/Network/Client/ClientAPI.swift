//
//  ClientAPI.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import CoreData

class ClientAPI {
    typealias SuccessBlock<T> = (_ result: T?) -> Void
    typealias SuccessResponseBlock<T> = (_ result: T?, _ response: HTTPURLResponse?) -> Void
    typealias FailureBlock = (_ failure: ClientError?) -> Void

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func get<T: Decodable>(request: URLRequest, for type: T.Type, success: @escaping SuccessBlock<T>, failure: @escaping FailureBlock) {
        let task = taskHandler(request: request, success: { data in
            do {
                let decoded = try JSONDecoder().decode(type, from: data)
                success(decoded)
            } catch let error {
                failure(.decodeFailure(error))
            }
        }, failure: failure)

        task.resume()
    }

    func get<T: Decodable>(request: URLRequest, for type: T.Type, success: @escaping SuccessResponseBlock<T>, failure: @escaping FailureBlock) {
        let task = taskHandler(request: request, success: { (data, response) in
            do {
                let decoded = try JSONDecoder().decode(type, from: data)
                success(decoded, response as? HTTPURLResponse)
            } catch let error {
                failure(.decodeFailure(error))
            }
        }, failure: failure)
        task.resume()
    }

    func taskHandler(request: URLRequest, success: @escaping (Data) -> Void, failure: @escaping (ClientError?) -> Void) -> URLSessionDataTaskProtocol {
        return taskHandler(request: request, success: { (data, response) in
            success(data)
        }, failure: failure)
    }

    func taskHandler(request: URLRequest, success: @escaping (Data, URLResponse?) -> Void, failure: @escaping (ClientError?) -> Void) -> URLSessionDataTaskProtocol {
        return session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                if let error = error as? URLError {
                    switch error.code {
                    case .notConnectedToInternet, .networkConnectionLost:
                        failure(.unavailableConnection(error))
                    default:
                        failure(.error(error))
                    }
                } else {
                    failure(.error(error))
                }
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 403 else {
                failure(.unauthorized(self.customError("You're not authorized to access this resource")))
                return
            }

            guard statusCode >= 200 && statusCode <= 299 else {
                failure(.networkFailure(self.customError("Request failed with status code of \(statusCode)")))
                return
            }

            if let data = data {
                success(data, response)
            } else {
                failure(.noResultsFound(error))
            }
        })
    }

    fileprivate func customError(_ description: String) -> Error {
        let userInfo: [String: Any] = [NSLocalizedDescriptionKey: description]
        let error = NSError(domain: "network", code: 0, userInfo: userInfo)
        return error as Error
    }
}
