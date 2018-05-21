//
//  Parameters.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

struct Parameters {
    var query: [URLQueryItem] = [URLQueryItem]()
    var headers: [String: String]?

    init(_ parameters: [String: AnyObject] = [:], headers: [String: String] = [:]) {
        self.query = builQuery(with: parameters)
        self.headers = headers
    }

    func builQuery(with parameters: [String: AnyObject]) -> [URLQueryItem] {
        var query = [URLQueryItem]()
        if !parameters.isEmpty {
            for (name, value) in parameters {
                query.append(URLQueryItem(name: name, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))
            }
        }
        return query
    }

    func configureHeaders(for request: inout NSMutableURLRequest) {
        if let headers = headers, !headers.isEmpty {
            for (field, value) in headers {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
    }

    mutating func addParameter(_ name: String, value: AnyObject) {
        query.append(URLQueryItem(name: name, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))
    }

    mutating func addFilter(_ name: String, value: AnyObject) {
        query.append(URLQueryItem(name: "filter\(name)", value: "\(value)"))
    }
}

extension Parameters: CustomStringConvertible {
    var description: String {
        return query.map { queryItem in
            if let value = queryItem.value {
                return "\(queryItem.name)=\(value)"
            }
            return ""
            }.joined()
        return ""
    }
}
