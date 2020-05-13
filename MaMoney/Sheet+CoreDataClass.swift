//
//  Sheet+CoreDataClass.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 12/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//
//

import Foundation
import CoreData

protocol SheetRepositoryProcol: AnyObject {
    static func fetchSheets(from context: NSManagedObjectContext, completion: @escaping ([Sheet]?) -> Void)
    static func insertSheet(from context: NSManagedObjectContext)
    static func deleteSheet(from context: NSManagedObjectContext, sheet: Sheet)
}

public class Sheet: NSManagedObject, SheetRepositoryProcol {
    
    static func fetchSheets(from context: NSManagedObjectContext, completion: @escaping ([Sheet]?) -> Void) {
        do {
            let sheets: [Sheet] = try context.fetch(Sheet.fetchRequest())
            completion(sheets)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func insertSheet(from context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func deleteSheet(from context: NSManagedObjectContext, sheet: Sheet) {
        do {
            context.delete(sheet)
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
