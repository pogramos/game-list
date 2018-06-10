//
//  IGDBError.swift
//  Game List
//
//  Created by Guilherme Ramos on 10/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

struct IGDBError: Decodable {
    struct Package: Decodable {
        let status: Int?
        let message: String?
    }
    let err: Package?

    enum CodingKeys: String, CodingKey {
        case err = "Err"
    }
}
