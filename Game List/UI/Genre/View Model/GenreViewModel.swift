//
//  GenreViewModel.swift
//  Game List
//
//  Created by Guilherme on 5/6/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

protocol GenreViewModelDelegate: class {
    func updateUI()
}

class GenreViewModel {
    func fetchGenres () {
        let parameters = Parameters([
            "fields": "id,name" as AnyObject
            ])
        //        IGDBApi.getGenres(with: parameters, success: { (genres) in
        //            print(genres ?? "")
        //        }, failure: { (error) in
        //            print(error)
        //        })
    }
}
