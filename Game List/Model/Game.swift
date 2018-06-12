//
//  Game.swift
//  Game List
//
//  Created by Guilherme Ramos on 18/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation
// sourcery: Codable, CoreDataEquivalency
struct Game: Decodable {
    var id: Int64?
    var name: String?
    var summary: String?
    var storyline: String?
    var first_release_date: Int64?
    // sourcery:begin: unconvertible
    var release_dates: [ReleaseDate]?
    var cover: Image?
    var screenshots: [Image]?
    // sourcery:end
}
