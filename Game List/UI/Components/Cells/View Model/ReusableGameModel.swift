//
//  ReusableGameModel.swift
//  Game List
//
//  Created by Guilherme Ramos on 02/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation
import CoreData

class ReusableGameModel {
    private let game: CoreDataGame?

    var image: Data? {
        return game?.cover
    }

    var title: String? {
        return game?.name
    }

    var favorite: Bool {
        return game?.favorite ?? false
    }

    var summary: String? {
        return game?.summary
    }

    init(game: CoreDataGame?) {
        self.game = game
    }
}
