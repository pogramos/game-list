//
//  Parameters.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

struct Parameters {
    var shouldScroll: Bool = false
    var scrollingPath: String?
    var query: [URLQueryItem]?
    var headers: [String: String]?

    enum Order: String {
        case desc
        case asc
    }

    init(_ parameters: [String: AnyObject] = [:], headers: [String: String] = [:]) {
        self.query = builQuery(with: parameters)
        self.headers = headers
    }

    init(_ parameters: [String: AnyObject] = [:], headers: [String: String] = [:], path: String?) {
        self.init(parameters, headers: headers)
        self.scrollingPath = path
        self.shouldScroll = true
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

    mutating func addFilter(_ name: String, value: AnyObject) {
        if query == nil {
            query = [URLQueryItem]()
        }
        query?.append(URLQueryItem(name: "filter\(name)", value: "\(value)"))
    }

    mutating func addParameter(_ name: String, value: AnyObject) {
        if query == nil {
            query = [URLQueryItem]()
        }
        query?.append(URLQueryItem(name: name, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))
    }

    mutating func sort(_ name: String, order: Order) {
        if query == nil {
            query = [URLQueryItem]()
        }
        if let orderName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            query?.append(URLQueryItem(name: "order", value: "\(orderName):\(order)"))
        }
    }

    mutating func removeParameter(_ name: String) {
        query = query?.filter({ (item) -> Bool in
            item.name != name
        })
    }
}

extension Parameters: CustomStringConvertible {
    var description: String {
        if let query = query, query.count > 0 {
            let map = query.filter { (item) -> Bool in
                if let value = item.value {
                    return !value.isEmpty
                }
                return false
                }.map { (item) -> String in
                    return "\(item.name)=\(item.value!)"
                }.joined(separator: "&")
            return "?\(map)"
        }
        return ""
    }
}
