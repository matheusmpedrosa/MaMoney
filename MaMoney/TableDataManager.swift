//
//  TableDataManager.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 15/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import CoreData

class TableDataManager: DataManagerProtocol {
    
    var context: NSManagedObjectContext
    
    required init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchAll(completion: @escaping ([Any]?) -> Void) {
        Table.fetchObjects(from: context) { (result) in
            if let result = result as? [Table] {
                completion(result)
            } else {
                completion(nil)
            }
        }
    }
    
    func insert(object: Any) {
        Table.insertObject(from: context)
    }
    
    func delete(object: Any) {
        Table.deleteObject(from: context, object: object)
    }
    
}

extension TableDataManager {
    func insertNewTable(title: String, color: String, total: NSDecimalNumber) {
        let newTable = Table(context: context)
        newTable.title = title
        newTable.color = color
        newTable.totalAmount = total
        newTable.item = NSSet.init(array: [])
        
        self.insert(object: newTable)
    }
}
