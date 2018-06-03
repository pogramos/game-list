//
//  RecentsViewModel.swift
//  Game List
//
//  Created by Guilherme Ramos on 02/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation
import CoreData

class RecentsViewModel {
    private let cacheName: String?
    private let sortDescriptors: [NSSortDescriptor]!
    lazy private var fetchedResultsController: NSFetchedResultsController<CoreDataGame> = makeFetchedResultsController()
    private func makeFetchedResultsController() -> NSFetchedResultsController<CoreDataGame> {
        let fetchRequest: NSFetchRequest<CoreDataGame> = CoreDataGame.fetchRequest()
        fetchRequest.sortDescriptors = sortDescriptors
        let fetchedResultsController: NSFetchedResultsController<CoreDataGame> = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: DataController.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: cacheName
        )
        return fetchedResultsController
    }

    init(_ cacheName: String?, sortDescriptors: [NSSortDescriptor]) {
        self.cacheName = cacheName
        self.sortDescriptors = sortDescriptors
    }

    func fetchGames() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to fetch games")
        }
    }

    func numberOfRows() -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func game(at indexPath: IndexPath) -> CoreDataGame? {
        return fetchedResultsController.fetchedObjects?[indexPath.row]
    }
}
