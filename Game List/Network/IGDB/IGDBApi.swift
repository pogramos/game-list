//
//  IGDBClient.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

class IGDBApi {
    class func getGenres(with parameters: Parameters, success: @escaping ([Genre]?) -> Void, failure: @escaping (ClientError) -> Void) {
        do {
            let request = try build(method: .genre, with: parameters)
            ClientAPI().get(request: request, for: [Genre].self, success: { genres in
                success(genres)
            }, failure: { error in
                failure(error ?? .error(nil))
            })
        } catch let getError {
            failure(.error(getError))
        }
    }

    class func getGames(with parameters: Parameters, success: @escaping () -> Void, failure: @escaping (ClientError) -> Void) {

    }
}

extension IGDBApi {
    class fileprivate func build(method: Method, with parameters: Parameters) throws -> URLRequest {

        var parameters = parameters
        parameters.headers = [
            HeaderKey.UserKey: HeaderValues.UserKey,
            HeaderKey.Accept: HeaderValues.ApplicationJSON
        ]

        return try RequestBuilder.buildRequest(scheme: Constants.APIScheme,
                                               host: Constants.APIHost,
                                               path: method.rawValue,
                                               parameters: parameters)
    }
}

extension IGDBApi {
    fileprivate struct Constants {
        static let APIScheme = "https"
        static let APIHost = "api-endpoint.igdb.com"
    }

    fileprivate struct HeaderValues {
        static let UserKey = "25130dce7d3ac8440f3a906a38b3d603"
        static let ApplicationJSON = "application/json"
    }

    fileprivate struct HeaderKey {
        static let UserKey = "user-key"
        static let Accept = "Accept"
    }

    fileprivate enum Method: String {
        case genre = "/genres/"
    }
}
