//
//  Entry+Convenience.swift
//  Journal
//
//  Created by Lewis Jones on 31/08/2018.
//  Copyright © 2018 Lewis Jones. All rights reserved.
//

import Foundation
import CoreData


extension Entry {
    convenience init(title: String, category: String? = nil, text: String, timestamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.context){
        
        
        self.init(context: context)
        
        self.title = title
        self.category = category
        self.text = text
        self.timestamp = timestamp
        
    }
    
}
