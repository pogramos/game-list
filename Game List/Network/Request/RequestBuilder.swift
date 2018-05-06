//
//  RequestBuilder.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

class RequestBuilder {

    /// Checks the path and in case it isn't empty, insert a new slash at the begining of the string
    ///
    /// - Parameter path: API Path
    /// - Returns: A new fixed path in case it is passed without the slash, otherwise return without editing it
    fileprivate class func checkAndFix(_ path: String) -> String {
        var path = path
        if path != "" && path.prefix(path.startIndex.encodedOffset) != "/" {
            path.insert("/", at: path.startIndex)
        }
        return path
    }

    /// Build a URL Request with the given structure scheme://host/path?/?parameters
    /// in case a path or parameters doesn't exists, the method will omit them on the final url
    ///
    /// - Parameters:
    ///   - scheme: URL protocol for the request. e.g.: http/https
    ///   - host: Base url. google.com
    ///   - path: Path or method of the api
    ///   - parameters: Parameter object that will define both headers and querystring for the request
    /// - Returns: An url request created with the given parameters
    /// - Throws: a ClientError if the url cannot be created
    class func buildRequest(scheme: String, host: String, path: String = "", parameters: Parameters?) throws -> URLRequest {
        // it will check for a starting slash
        // in case the path isn't empty
        let path = checkAndFix(path)

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = parameters?.query

        guard let url = components.url else { throw ClientError.encodeFailure(nil) }

        var request = NSMutableURLRequest(url: url)

        parameters?.configureHeaders(for: &request)

        return request as URLRequest
    }
}
