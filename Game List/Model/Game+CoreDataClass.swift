//
//  Game+CoreDataClass.swift
//  Game List
//
//  Created by Guilherme Ramos on 14/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Game)
public class Game: NSManagedObject {
    public required convenience init(from decoder: Decoder) throws {
        let entityName = String(describing: Game.self)
        guard let contextKey = CodingUserInfoKey.context else {
            fatalError("Could not find contextKey")
        }
        guard let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext else {
            fatalError("Could not extract the context from the decoder")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext) else {
            fatalError("Failed to decode \(entityName)")
        }

        self.init(entity: entity, insertInto: nil)

        try customDecoder(from: decoder)
    }
}
