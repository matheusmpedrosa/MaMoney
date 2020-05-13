//
//  Item+CoreDataProperties.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 13/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var date: Date
    @NSManaged public var instalments: Int16
    @NSManaged public var isInstalment: Bool
    @NSManaged public var title: String
    @NSManaged public var value: NSDecimalNumber
    @NSManaged public var ofTable: Table?

}
