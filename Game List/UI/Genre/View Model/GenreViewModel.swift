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

    /// Tells the delegate to show a dialog for the current viewcontroller
    /// indicating that the operation failed, sending the message
    ///
    /// - Parameter message: Message returned by a operation failure
    func showErrorOnUI(_ message: String)
}

class GenreViewModel {
    let cellIdentifier = "GenreTableViewCell"

    weak var delegate: GenreViewModelDelegate!

    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Genre> = makeFetchedResultsController()

    fileprivate func makeFetchedResultsController() -> NSFetchedResultsController<Genre> {
        let fetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        fetchRequest.sortDescriptors = []
        let fetchedResultsController: NSFetchedResultsController<Genre> = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: DataController.shared.viewContext,
            sectionNameKeyPath: "name",
            cacheName: "Genres"
        )

        return fetchedResultsController
    }

    fileprivate func save(genres: [Genre]?) {
        if let genres = genres {
            for genre in genres {
                DataController.shared.insert(object: genre)
            }
            DataController.shared.save()
        }
    }

    func numberOfSections() -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func numberOfItemsInSection(section: Int) -> Int {
        return 0
    }

    func genreTitle(at section: Int) -> String {
        if let sectionInfo = fetchedResultsController.sections?[section] {
            return sectionInfo.name
        }
        return ""
    }

    func genre(at indexPath: IndexPath) -> Genre {
        return fetchedResultsController.object(at: indexPath)
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
            IGDBApi.getGenres(with: parameters, on: DataController.shared.viewContext, success: { genres in
                self.save(genres: genres)
                performUIOnMainThread {
                    self.delegate.updateUI()
                }
            }, failure: { (error) in
                performUIOnMainThread {
                    self.delegate.showErrorOnUI(error.localizedDescription)
                }
            })
        }
    }
}
