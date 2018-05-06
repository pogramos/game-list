//
//  Parameters.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

struct Parameters {
    var query: [URLQueryItem]?
    var headers: [String: String]?

    init(_ parameters: [String: AnyObject] = [:], headers: [String: String] = [:]) {
        self.query = builQuery(with: parameters)
        self.headers = headers
    }

    func builQuery(with parameters: [String: AnyObject]) -> [URLQueryItem]? {
        if !parameters.isEmpty {
            var query = [URLQueryItem]()

            for (name, value) in parameters {
                query.append(URLQueryItem(name: name, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))
            }

            return query
        }
        return nil
    }

    func configureHeaders(for request: inout NSMutableURLRequest) {
        if let headers = headers, !headers.isEmpty {
            for (field, value) in headers {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
    }
}

extension Parameters: CustomStringConvertible {
    var description: String {
        if let query = query {
            return query.map { queryItem in
                if let value = queryItem.value {
                    return "\(queryItem.name)=\(value)"
                }
                return ""
            }.joined()
        }
        return ""
    }
}
