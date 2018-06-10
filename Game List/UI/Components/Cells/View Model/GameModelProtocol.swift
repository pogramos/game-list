//
//  GameModelProtocol.swift
//  Game List
//
//  Created by Guilherme Ramos on 02/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

protocol GameViewModelProtocol: class {
    var title: String? { get }
    var release: String? { get }
    var summary: String? { get }
    var favorite: Bool { get }

    init()
    init(game: Game)
    init(core: CoreDataGame)

    func fetchCoverImage(_ completion: @escaping (Data?) -> Void)
    func toggleFavorite()
}

extension GameViewModelProtocol {
    init(game: Game) {
        self.init()
    }
    init(core: CoreDataGame) {
        self.init()
    }
    func toggleFavorite() {}
    func fetchCoverImage(_ completion: @escaping (Data?) -> Void) {}
}
