//
//  Genre.swift
//  Game List
//
//  Created by Guilherme Ramos on 18/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation
// sourcery: Codable, CoreDataEquivalency
struct Genre: Codable {
    var id: Int32?
    var url: String?
    var name: String?
    // sourcery: skip, unconvertible
    var games: [Game]?
    var created_at: Int64?
    var updated_at: Int64?
}
