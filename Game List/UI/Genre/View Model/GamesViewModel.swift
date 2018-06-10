//
//  GamesViewModel.swift
//  Game List
//
//  Created by Guilherme Ramos on 05/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

class GamesViewModel {
    private var searchText: String? {
        didSet {
            if let searchText = searchText, !searchText.isEmpty {
                filteredGames = games.filter { (game) -> Bool in
                    if let name = game.name {
                        return name.contains(searchText)
                    }
                    return false
                }
            } else {
                filteredGames = games
            }
        }
    }
    private let genre: Genre
    private var games = [Game]() {
        didSet {
            filteredGames = games
        }
    }
    private var filteredGames = [Game]()
    private lazy var parameters = self.makeParameters()
    private func makeParameters() -> Parameters {
        return Parameters([
            IGDBApi.ParameterKeys.Fields: Game.fields() as AnyObject,
            IGDBApi.ParameterKeys.Limit: "50" as AnyObject,
            IGDBApi.ParameterKeys.Scroll: "1" as AnyObject,
            IGDBApi.ParameterKeys.FilterGenre: genre.id as AnyObject
        ], headers: [:])
    }
    weak var delegate: ControllersProtocol!

    var title: String? {
        return genre.name
    }

    init(with genre: Genre) {
        self.genre = genre
        parameters.sort("release_dates.date", order: .desc)
    }

    func numberOfItems() -> Int {
        return filteredGames.count
    }

    func game(at indexPath: IndexPath) -> Game {
        return filteredGames[indexPath.row]
    }

    func filter(withText text: String?) {
        searchText = text
        if let text = searchText?.lowercased() {
            if filteredGames.count > 0 {
                delegate.updateUI()
            } else {
                filteredGames = [Game]()
                parameters = makeParameters()
                parameters.addFilter("[name][any]", value: text as AnyObject)
                fetchGames()
            }
        } else {
            delegate.updateUI()
        }
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
