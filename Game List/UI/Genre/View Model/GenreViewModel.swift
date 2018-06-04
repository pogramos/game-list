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
    var gameOffSet = 0
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
        IGDBApi.getGenres(with: Parameters(), success: { genres in
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
        if let expanded = genres?[section].expanded, expanded {
            return genres?[section].games?.count ?? 0
        }
        return 0
    }

    // MARK: Genres
    func genreTitle(at section: Int) -> String {
        return genres?[section].name ?? ""
    }

    func genre(at section: Int) -> Genre? {
        return genres?[section]
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

    /// Toggles the table view for a given section,
    /// If there's no value to the **expanded** property it means that
    /// the section wasn't expanded yet, so it means that it must be set to **true**
    ///
    /// - Parameter section: given section from an indexpath
    func toggle(section: Int) {
        if let expanded = genres?[section].expanded {
            genres?[section].expanded = !expanded
        } else {
            genres?[section].expanded = true
        }

        fetchGames(for: section)
    }

    func fetchMore(for section: Int) {
        gameOffSet += 50
        guard let genre = genres?[section] else {
            return
        }
        fetch(genre, section)
    }

    func fetchGames(for section: Int) {
        guard let genre = genres?[section], (genre.games == nil || genre.games!.count == 0) else {
            return
        }
        fetch(genre, section)
    }

    fileprivate func fetch(_ genre: Genre, _ section: Int) {
        var parameter = Parameters()
        parameter.addParameter(IGDBApi.ParameterKeys.Offset, value: gameOffSet as AnyObject)
        IGDBApi.getGames(for: genre, with: parameter, success: { games in
            if self.genres?[section].games == nil {
                self.genres?[section].games = games
            } else {
                if let games = games {
                    self.genres?[section].games?.append(contentsOf: games)
                } else {
                    self.genres?[section].games = []
                }
            }
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
