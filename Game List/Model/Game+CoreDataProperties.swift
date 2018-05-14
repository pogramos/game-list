//
//  Game+CoreDataProperties.swift
//  Game List
//
//  Created by Guilherme Ramos on 14/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//
//

import Foundation
import CoreData


extension Game: AutoNSManagedCodableObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var genres: Set<Int>?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var storyline: String?
    @NSManaged public var summary: String?
    @NSManaged public var cover: Screenshot?
    @NSManaged public var screenshots: Set<Screenshot>?
}

// MARK: Generated accessors for screenshots
extension Game {

    @objc(addScreenshotsObject:)
    @NSManaged public func addToScreenshots(_ value: Screenshot)

    @objc(removeScreenshotsObject:)
    @NSManaged public func removeFromScreenshots(_ value: Screenshot)

    @objc(addScreenshots:)
    @NSManaged public func addToScreenshots(_ values: NSSet)

    @objc(removeScreenshots:)
    @NSManaged public func removeFromScreenshots(_ values: NSSet)

}
