//
//  GamesViewModel.swift
//  Game List
//
//  Created by Guilherme Ramos on 05/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

class GamesViewModel {
    private let genre: Genre
    private var games = [Game]()

    weak var delegate: ControllersProtocol!

    var title: String? {
        return genre.name
    }

    init(with genre: Genre) {
        self.genre = genre
    }

    func numberOfItems() -> Int {
        return games.count
    }

    func game(at indexPath: IndexPath) -> Game {
        return games[indexPath.row]
    }

    func fetchGames() {
        IGDBApi.getGames(for: genre, with: Parameters(), success: { (games) in
            if let games = games {
                self.games = games
            }
            performUIUpdatesOnMain {
                self.delegate.updateUI()
            }
        }, failure: { error in
            performUIUpdatesOnMain {
                self.delegate.showErrorOnUI(error.localizedDescription)
            }
        })
    }
}
