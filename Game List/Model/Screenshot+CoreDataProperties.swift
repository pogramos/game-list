//
//  Screenshot+CoreDataProperties.swift
//  Game List
//
//  Created by Guilherme Ramos on 12/05/2018.
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
    // sourcery: skippable
    @NSManaged public var data: NSData?

}
