//
//  CoreDataGenre+CoreDataClass.swift
//  Game List
//
//  Created by Guilherme Ramos on 18/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CoreDataGenre)
public class CoreDataGenre: NSManagedObject {
    var items: [Game]?
}
