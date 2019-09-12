//
//  CoreDataStack.swift
//  Journal
//
//  Created by Lewis Jones on 31/08/2018.
//  Copyright © 2018 Lewis Jones. All rights reserved.
//

import Foundation
import CoreData



enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Journal")
        container.loadPersistentStores() { (storeDecription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
 
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}
