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

    fileprivate var persistentContainer: NSPersistentContainer!

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    fileprivate init() {
        persistentContainer = NSPersistentContainer(name: modelName)
    }

    fileprivate func autoSaveContext(interval: TimeInterval = 30) {
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }

        save()

        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveContext(interval: interval)
        }
    }

    func load() {
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Failed to load persistentContainer \(error), \(error.userInfo)")
            }
            self.viewContext.automaticallyMergesChangesFromParent = true
            self.autoSaveContext()
        }
    }

    func insert(object: NSManagedObject) {
        viewContext.insert(object)
    }

    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
