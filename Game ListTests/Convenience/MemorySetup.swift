//
//  MemorySetup.swift
//  Game ListTests
//
//  Created by Guilherme Ramos on 14/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import CoreData

func setupMemoryViewContext() -> NSManagedObjectContext {
    guard let managedObjectModel = NSManagedObjectModel.mergedModel(from: [.main]) else {
        fatalError("Unresolved error")
    }
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    do {
        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    } catch {
        print("failed to setup memory context")
    }
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    return managedObjectContext
}
