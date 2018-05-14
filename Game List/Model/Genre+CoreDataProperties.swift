//
//  Genre+CoreDataProperties.swift
//  Game List
//
//  Created by Guilherme Ramos on 14/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//
//

import Foundation
import CoreData


extension Genre: AutoNSManagedCodableObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var created_at: Int64
    @NSManaged public var games: Set<Int>?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var updated_at: Int64
    @NSManaged public var url: String?

}
