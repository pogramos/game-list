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
    private var parameters = Parameters([
        IGDBApi.ParameterKeys.Fields: Game.fields() as AnyObject,
        IGDBApi.ParameterKeys.Limit: "50" as AnyObject,
        IGDBApi.ParameterKeys.Scroll: "1" as AnyObject
        ], headers: [:])
    weak var delegate: ControllersProtocol!

    var title: String? {
        return genre.name
    }

    init(with genre: Genre) {
        self.genre = genre
        parameters.addParameter(IGDBApi.ParameterKeys.FilterGenre, value: genre.id as AnyObject)
    }

    func numberOfItems() -> Int {
        return games.count
    }

    func game(at indexPath: IndexPath) -> Game {
        return games[indexPath.row]
    }

    @objc func fetchGames() {
        IGDBApi.fetchScrollingGames(with: parameters, success: { [weak self] (games, parameters) in
            self?.parameters = parameters
            if let games = games {
                self?.games.append(contentsOf: games)
            }
            performUIUpdatesOnMain {
                self?.delegate.updateUI()
            }
        }, failure: { [weak self] error in
            performUIUpdatesOnMain {
                self?.delegate.showErrorOnUI(error.localizedDescription)
            }
        })
    }
}
