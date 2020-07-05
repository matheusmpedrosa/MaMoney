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

public class Sheet: NSManagedObject, RepositoryProtocol {
    
    static func fetchObjects(from context: NSManagedObjectContext, completion: @escaping ([Any]?) -> Void) {
        do {
            let sheets: [Sheet] = try context.fetch(Sheet.fetchRequest())
            completion(sheets)
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
            guard let sheet = object as? Sheet else { return }
            context.delete(sheet)
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
