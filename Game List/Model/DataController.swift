//
//  DataController.swift
//  Game List
//
//  Created by Guilherme Ramos on 11/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation
import CoreData

final class DataController {
    typealias LoadCompletion = () -> Void

    static let shared: DataController = DataController()

    fileprivate let modelName = "Game_List"

    lazy var persistentContainer: NSPersistentContainer = self.makePersistentContainer()

    fileprivate func makePersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Failed to load persistentContainer \(error), \(error.userInfo)")
            }

            self.autoSaveContext()
        }
        return container
    }
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    fileprivate init() {}

    fileprivate func autoSaveContext(interval: TimeInterval = 30) {
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }

        if self.viewContext.hasChanges {
            do {
                try self.viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveContext(interval: interval)
        }
    }
}
