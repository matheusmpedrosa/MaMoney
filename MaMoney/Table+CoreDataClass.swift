//
//  Table+CoreDataClass.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 12/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//
//

import Foundation
import CoreData


public class Table: NSManagedObject, RepositoryProtocol {
    
    static func fetchObjects(from context: NSManagedObjectContext, completion: @escaping ([Any]?) -> Void) {
        do {
            let tables: [Table] = try context.fetch(Table.fetchRequest())
            completion(tables)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func insertObject(from context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func deleteObject(from context: NSManagedObjectContext, object: Any) {
        do {
            guard let table = object as? Table else { return }
            context.delete(table)
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
