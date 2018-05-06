//
//  Constants.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

struct Constants {
    enum Error: String {
        case forbiddenAccess = "Unauthorized user"
        case common = "There was an error processing your request"
        case encode = "Failed to encode object"
        case decode = "Failed to decode object"
        case notFound = "No data was returned by the request"
        case wrongPath = "Your path should either be empty or start with a single '/'"
    }
}
