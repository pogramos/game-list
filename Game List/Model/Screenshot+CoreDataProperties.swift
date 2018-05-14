//
//  Screenshot+CoreDataProperties.swift
//  Game List
//
//  Created by Guilherme Ramos on 14/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//
//

import Foundation
import CoreData


extension Screenshot: AutoNSManagedCodableObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Screenshot> {
        return NSFetchRequest<Screenshot>(entityName: "Screenshot")
    }

    @NSManaged public var url: String?
    // sourcery:begin: skipPersistence
    @NSManaged public var data: Data?
    @NSManaged public var cover_game: Game?
    @NSManaged public var screenshot_games: Game?
    // sourcery:end
}
