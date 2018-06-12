//
//  GenreViewModel.swift
//  Game List
//
//  Created by Guilherme on 5/6/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation
import CoreData

public enum GenreOperation {
    case add, delete
}

class GenreViewModel {
    let cellIdentifier = "GenreTableViewCell"
    weak var delegate: ControllersProtocol!

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
}
