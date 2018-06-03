//
//  CoreDataGame+CoreDataProperties.swift
//  Game List
//
//  Created by Guilherme Ramos on 30/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//
//

import Foundation
import CoreData

extension CoreDataGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataGame> {
        return NSFetchRequest<CoreDataGame>(entityName: "CoreDataGame")
    }

    @NSManaged public var cover: Data?
    @NSManaged public var first_release_date: Int64
    @NSManaged public var genres: Set<Int>?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var screenshots: Set<Data>?
    @NSManaged public var storyline: String?
    @NSManaged public var summary: String?
    @NSManaged public var favorite: Bool
}
