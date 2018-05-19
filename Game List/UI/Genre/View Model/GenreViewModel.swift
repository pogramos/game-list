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
    /// - Parameter indexPaths: index of the reloading section
    func updateUI(with indexSet: IndexSet)

    /// Tells the delegate to show a dialog for the current viewcontroller
    /// indicating that the operation failed, sending the message
    ///
    /// - Parameter message: Message returned by a operation failure
    func showErrorOnUI(_ message: String)
}

public enum GenreOperation {
    case add, delete
}

class GenreViewModel {
    let cellIdentifier = "GenreTableViewCell"
    weak var delegate: GenreViewModelDelegate!

    var genres: [Genre]?

    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<CoreDataGenre> = makeFetchedResultsController()

    fileprivate func makeFetchedResultsController() -> NSFetchedResultsController<CoreDataGenre> {
        let fetchRequest: NSFetchRequest<CoreDataGenre> = CoreDataGenre.fetchRequest()
        fetchRequest.sortDescriptors = []
        let fetchedResultsController: NSFetchedResultsController<CoreDataGenre> = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: DataController.shared.viewContext,
            sectionNameKeyPath: "name",
            cacheName: "Genres"
        )

        return fetchedResultsController
    }

    fileprivate func downloadGenres() {
        let parameters = Parameters([
            IGDBApi.ParameterKeys.Fields: Genre.fields() as AnyObject
            ])
        IGDBApi.getGenres(with: parameters, success: { genres in
            self.genres = genres
            self.save()
            performUIUpdatesOnMain {
                self.delegate.updateUI()
            }
        }, failure: { (error) in
            performUIUpdatesOnMain {
                self.delegate.showErrorOnUI(error.localizedDescription)
            }
        })
    }

    fileprivate func save() {
        if let genres = genres {
            for genre in genres {
                _ = genre.toCoreData(on: DataController.shared.viewContext)
            }
            DataController.shared.save()
        }

        try? fetchedResultsController.performFetch()
    }

    func numberOfSections() -> Int {
        return genres?.count ?? 0
    }

    func numberOfItemsInSection(section: Int) -> Int {
        return genres?[section].games?.count ?? 0
    }

    // MARK: Genres
    func genreTitle(at section: Int) -> String {
        return genres?[section].name ?? ""
    }

    /// Fetch a collection of genres from the service
    func fetchGenres () {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Unresolved error \(error)")
        }

        if let objects = fetchedResultsController.fetchedObjects, objects.count > 0 {
            genres = []
            for object in objects {
                genres?.append(object.toModel())
            }
            self.delegate.updateUI()
        } else {
            downloadGenres()
        }
    }

    // MARK: Games
    func game(at indexPath: IndexPath) -> Game? {
        return genres?[indexPath.section].games?[indexPath.row]
    }

    func fetchGames(for section: Int) {
        guard let genre = genres?[section] else {
            return
        }
        let parameters = Parameters([
            IGDBApi.ParameterKeys.Fields: Game.fields() as AnyObject
            ])
        IGDBApi.getGames(for: genre, with: parameters, success: { games in
            self.genres?[section].games = games
            performUIUpdatesOnMain {
                let set = IndexSet(arrayLiteral: section)
                self.delegate.updateUI(with: set)
            }
        }, failure: { (error) in
            performUIUpdatesOnMain {
                self.delegate.showErrorOnUI(error.localizedDescription)
            }
        })
    }
}
