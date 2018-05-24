//
//  IGDBClient.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import CoreData

class IGDBApi {
    class func getGenres(with parameters: Parameters, success: @escaping ([Genre]?) -> Void, failure: @escaping (ClientError) -> Void) {
        var parameters = parameters
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

    class func getGames(for genre: Genre, with parameters: Parameters, success: @escaping ([Game]?) -> Void, failure: @escaping (ClientError) -> Void) {
        var parameters = parameters
        parameters.addParameter(IGDBApi.ParameterKeys.Fields, value: Game.fields() as AnyObject)
        if let id = genre.id {
            parameters.addParameter(IGDBApi.ParameterKeys.FilterGenre, value: id as AnyObject)
            do {
                let request = try build(method: .game(nil), with: parameters)
                ClientAPI().get(request: request, for: [Game].self, success: { games in
                    success(games)
                }, failure: { error in
                    failure(error ?? .error(nil))
                })
            } catch let err {
                failure(.error(err))
            }
        } else {
            failure(.error(nil))
        }

    }

    class func getGame(for id: Int, with parameters: Parameters, success: @escaping (Game?) -> Void, failure: @escaping (ClientError) -> Void) {
        var parameters = parameters
        parameters.addParameter(IGDBApi.ParameterKeys.Fields, value: Game.fields() as AnyObject)
        do {
            let request = try build(method: .game(id), with: parameters)
            ClientAPI().get(request: request, for: [Game].self, success: { games in
                success(games?.first)
            }, failure: { error in
                failure(error ?? .error(nil))
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
            HeaderKey.UserKey: HeaderValues.UserKey,
            HeaderKey.Accept: HeaderValues.ApplicationJSON
        ]

        return try RequestBuilder.buildRequest(scheme: Constants.APIScheme,
                                               host: Constants.APIHost,
                                               path: method.description,
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

    struct ParameterKeys {
        static let Fields = "fields"
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
