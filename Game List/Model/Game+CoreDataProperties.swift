//
//  Game+CoreDataProperties.swift
//  Game List
//
//  Created by Guilherme Ramos on 12/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//
//

import Foundation
import CoreData

extension Game: AutoNSManagedCodableObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var storyline: String?

}
