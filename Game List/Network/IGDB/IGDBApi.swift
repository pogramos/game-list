//
//  IGDBClient.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import CoreData

class IGDBApi {
    typealias FailureBlock = (ClientError) -> Void
    class func getGenres(with parameters: Parameters, success: @escaping ([Genre]?) -> Void, failure: @escaping FailureBlock) {
        var parameters = parameters
        parameters.addParameter(IGDBApi.ParameterKeys.Limit, value: "50" as AnyObject)
        parameters.addParameter(IGDBApi.ParameterKeys.Fields, value: Genre.fields() as AnyObject)
        do {
            let request = try build(method: .genre(nil), with: parameters)
            ClientAPI().get(request: request, for: [Genre].self, success: { genres in
                success(genres)
            }, failure: { error in
                failure(error ?? .error(nil))
            })
        } catch let err {
            failure(.error(err))
        }
    }

    class func fetchScrollingGames(with parameters: Parameters, success: @escaping ([Game]?, Parameters) -> Void, failure: @escaping FailureBlock) {
        var parameters = parameters
        do {
            let request = try build(method: .game(nil), with: parameters)
            ClientAPI().get(request: request, for: [Game].self, success: { (games, response) in
                if let nextPage = response?.allHeaderFields[HeaderKey.NextPage] as? String {
                    parameters = Parameters(path: nextPage)
                    parameters.removeParameter(ParameterKeys.FilterGenre)
                } else {
                    parameters.shouldScroll = false
                }
                success(games, parameters)
            }, failure: { error in
                failure(error!)
            })
        } catch let err {
            failure(.error(err))
        }
    }

    /// Download images from url's
    ///
    /// - Parameters:
    ///   - url: url string of an image
    ///   - completion: completion block to execute after the proccess is finished
    class func downloadImage(from url: String, completion: @escaping (Data?, String?) -> Void) {
        var urlComponent = URLComponents(string: url)!
        urlComponent.scheme = Constants.APIScheme
        let request = URLRequest(url: urlComponent.url!)
        let task = ClientAPI().taskHandler(request: request, success: { data in
            performUIUpdatesOnMain {
                completion(data, nil)
            }
        }, failure: { error in
            performUIUpdatesOnMain {
                completion(nil, error?.localizedDescription)
            }
        })
        task.resume()
    }
}

extension IGDBApi {
    class fileprivate func build(method: Method, with parameters: Parameters) throws -> URLRequest {

        var parameters = parameters
        parameters.headers = [
            HeaderKey.UserKey: HeaderValues.UserKey
        ]

        var path = method.description
        if parameters.shouldScroll, let scrollingPath = parameters.scrollingPath, !scrollingPath.isEmpty {
            path = scrollingPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }

        return try RequestBuilder.buildRequest(scheme: Constants.APIScheme,
                                               host: Constants.APIHost,
                                               path: path,
                                               parameters: parameters)
    }
}

extension IGDBApi {
    fileprivate struct Constants {
        static let APIScheme = "https"
        static let APIHost = "api-endpoint.igdb.com"
    }

    fileprivate struct HeaderValues {
        static var UserKey: String {
            if let key = Bundle.main.object(forInfoDictionaryKey: "SERVICE_KEY") as? String {
                return key
            }
            return ""
        }
        static let ApplicationJSON = "application/json"
    }

    fileprivate struct HeaderKey {
        static let UserKey = "user-key"
        static let ContentType = "content-type"
        static let NextPage = "x-next-page"
    }

    struct ParameterKeys {
        static let Limit = "limit"
        static let Fields = "fields"
        static let Offset = "offset"
        static let Scroll = "scroll"
        static let FilterGenre = "filter[genres][eq]"
    }

    enum Method: CustomStringConvertible {
        case genre(Int?)
        case game(Int?)

        var description: String {
            switch self {
            case .genre(.none):
                return "/genres/"
            case let .genre(id?):
                return "/genres/\(String(describing: id))"
            case .game(.none):
                return "/games/"
            case let .game(id?):
                return "/games/\(id)"
            }
        }
    }
}
