//
//  EntryController.swift
//  Journal
//
//  Created by Lewis Jones on 10/07/2018.
//  Copyright © 2018 Lewis Jones. All rights reserved.
//

import Foundation
import  CoreData


class EntryController {
    
    
    static let shared  = EntryController()
    
    
    
//    var entries: [Entry] = []
    
//    init(){
//        loadFromPersistenceStorage()
//    }
    
    
    var predicate: NSPredicate?
    
//    var entries: [Entry] {
//        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
//        request.predicate = predicate
//        do {
//          return try CoreDataStack.context.fetch(request)
//        } catch {
//            print("Error fetching entries: \(error)")
//            return []
//        }
//    }
    
    
    // CRUD

    func add(entry: Entry) {
        saveToPersistentStorage()
    }
    
    
    func remove(entry: Entry) {
        if let moc = entry.managedObjectContext {
            moc.delete(entry)
            saveToPersistentStorage()
        }
    }


    
    func update(entry: Entry, with title: String, category: String, text: String) {
        entry.title = title
        entry.text = text
        entry.category = category
        saveToPersistentStorage()
    }
    
    
    
    // MARK: - Persistence
    
//    func fileURL() -> URL {
//
//        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let fileName = "journal.json"
//        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
//        return documentsDirectoryURL
//
//    }
    
    
//        func loadFromPersistenceStorage() {
//
//            let decoder = JSONDecoder()
//
//            do {
//                let data = try Data(contentsOf: fileURL())
//                let entries = try decoder.decode([Entry].self, from: data)
//                self.entries = entries
//            } catch let error {
//                print("Error loading object: \(error)")
//            }
//        }
    
    
    
    func saveToPersistentStorage() {
      
        do {
           try CoreDataStack.context.save()
        } catch let error {
            print("Error encoding object \(error)")
        }
    }
}


