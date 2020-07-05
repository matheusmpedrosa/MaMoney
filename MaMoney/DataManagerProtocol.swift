//
//  DataManagerProtocol.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 15/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    var context: NSManagedObjectContext { get }
    init(context: NSManagedObjectContext)
    func getContext() -> NSManagedObjectContext
    func fetchAll(completion: @escaping ([Any]?) -> Void)
    func insert(object: Any)
    func delete(object: Any)
}

extension DataManagerProtocol {
    func getContext() -> NSManagedObjectContext {
        return context
    }
}
