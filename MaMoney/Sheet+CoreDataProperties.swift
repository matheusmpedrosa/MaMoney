//
//  Sheet+CoreDataProperties.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 13/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//
//

import Foundation
import CoreData


extension Sheet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sheet> {
        return NSFetchRequest<Sheet>(entityName: "Sheet")
    }

    @NSManaged public var date: Date
    @NSManaged public var title: String
    @NSManaged public var table: NSSet

}

// MARK: Generated accessors for table
extension Sheet {

    @objc(addTableObject:)
    @NSManaged public func addToTable(_ value: Table)

    @objc(removeTableObject:)
    @NSManaged public func removeFromTable(_ value: Table)

    @objc(addTable:)
    @NSManaged public func addToTable(_ values: NSSet)

    @objc(removeTable:)
    @NSManaged public func removeFromTable(_ values: NSSet)

}
