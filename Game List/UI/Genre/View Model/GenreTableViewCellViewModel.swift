//
//  GenreTableViewCellViewModel.swift
//  Game List
//
//  Created by Guilherme on 5/6/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

protocol GenreTableViewCellViewModelProtocol {
    func updateUI()
}

class GenreTableViewCellViewModel {
    fileprivate var genre: Genre!
    fileprivate var games: [Game]?

    var folded: Bool = true

    var title: String? {
        return genre.name
    }

    init(with genre: Genre) {
        self.genre = genre
    }
}
