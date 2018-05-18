//
//  GenreViewModel.swift
//  Game List
//
//  Created by Guilherme on 5/6/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation
import CoreData

protocol GenreViewModelDelegate: class {
    /// Tells the delegate to update the viewController's UI
    func updateUI()

    /// Tells the delegate to update the tableView section on
    ///
    /// - Parameter section: index of the reloading section
    func updateUI(section: Int)

    /// Tells the delegate to show a dialog for the current viewcontroller
    /// indicating that the operation failed, sending the message
    ///
    /// - Parameter message: Message returned by a operation failure
    func showErrorOnUI(_ message: String)
}

class GenreViewModel {
    let cellIdentifier = "GenreTableViewCell"
    weak var delegate: GenreViewModelDelegate!

    var openGenre: Genre?

    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<CoreDataGenre> = makeFetchedResultsController()

    fileprivate func makeFetchedResultsController() -> NSFetchedResultsController<CoreDataGenre> {
        let fetchRequest: NSFetchRequest<CoreDataGenre> = CoreDataGenre.fetchRequest()
        fetchRequest.sortDescriptors = []
        let fetchedResultsController: NSFetchedResultsController<CoreDataGenre> = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: DataController.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: "Genres"
        )

        return fetchedResultsController
    }

    fileprivate func save(genres: [Genre]?) {
        if let genres = genres {
            for genre in genres {
                _ = genre.toCoreData(on: DataController.shared.viewContext)
            }
            DataController.shared.save()
        }

        try? fetchedResultsController.performFetch()
    }

    func numberOfItemsInSection(section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func numberOfItemsInSection(section: Int) -> Int {
//        if let games = openGenre?.games {
//            return games.count
//        }
        return 0
    }

    // MARK: Genres
    func genreTitle(at section: Int) -> String {
        return fetchedResultsController.sections?[section].name ?? ""
    }

    func genre(at indexPath: IndexPath) -> Genre {
        return fetchedResultsController.object(at: indexPath).toModel()
    }

    /// Fetch a collection of genres from the service
    func fetchGenres () {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Unresolved error \(error)")
        }

        if let genres = fetchedResultsController.fetchedObjects, genres.count > 0 {
            self.delegate.updateUI()
        } else {
            let parameters = Parameters([
                IGDBApi.ParameterKeys.Fields: Genre.fields() as AnyObject
                ])
            IGDBApi.getGenres(with: parameters, success: { genres in
                self.save(genres: genres)
                performUIUpdatesOnMain {
                    self.delegate.updateUI()
                }
            }, failure: { (error) in
                performUIUpdatesOnMain {
                    self.delegate.showErrorOnUI(error.localizedDescription)
                }
            })
        }
    }

    // MARK: Games
    func game(at indexPath: IndexPath) -> Game {
        return Game()
    }

    func fetchGames(for genre: Genre) {
        let parameters = Parameters([
            IGDBApi.ParameterKeys.Fields: Game.fields() as AnyObject
            ])
        IGDBApi.getGames(with: parameters, success: { (games) in

        }, failure: { (error) in

        })
    }
}
