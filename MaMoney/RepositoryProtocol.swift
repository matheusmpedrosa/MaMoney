//
//  RepositoryProtocol.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 15/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import CoreData

protocol RepositoryProtocol: AnyObject {
    static func fetchObjects(from context: NSManagedObjectContext, completion: @escaping ([Any]?) -> Void)
    static func insertObject(from context: NSManagedObjectContext)
    static func deleteObject(from context: NSManagedObjectContext, object: Any)
}
