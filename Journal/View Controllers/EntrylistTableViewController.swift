//
//  EntrylistTableViewController.swift
//  Journal
//
//  Created by Lewis Jones on 13/07/2018.
//  Copyright © 2018 Lewis Jones. All rights reserved.
//

import UIKit
import CoreData

class EntrylistTableViewController: UITableViewController, UISearchBarDelegate, NSFetchedResultsControllerDelegate {

    
    let fetchResultsController: NSFetchedResultsController<Entry> = {
        
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        let resultsController: NSFetchedResultsController<Entry> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        return resultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     fetchResultsController.delegate = self
     tableView.reloadData()
        do {
            try fetchResultsController.performFetch()
        } catch let error {
            print("Error performing fetch, \(error)")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
        //return EntryController.shared.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        
        let entry = fetchResultsController.object(at: indexPath)
        //let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
       
        return cell
    }
    
    
    // Override to support editing the table view.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Gets index found at entries array on EntryController from row the user tapped on.
            
            let entry = fetchResultsController.object(at: indexPath)
            //let entry = EntryController.shared.entries[indexPath.row]
            
            // Delete the row from the data source
            EntryController.shared.remove(entry: entry)
          //  tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - UISearchBarDelegate
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            EntryController.shared.predicate = nil
            tableView.reloadData()
            return
        }
        
        
        let titlePredicate = NSPredicate(format: "title contains[cd] %@", argumentArray: [searchText])
        let textPredicate = NSPredicate(format: "text contains[cd] %@", argumentArray: [searchText])
        let categoryPredicate = NSPredicate(format: "category contains[cd] %@", argumentArray: [searchText])
        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [titlePredicate, textPredicate, categoryPredicate])
        EntryController.shared.predicate = predicate
        tableView.reloadData()
    }
    
    
    
    // MARK: - NSFetchedResultsCOntrollerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else { break }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToEntryDetail" {
            
            // Get the new view controller using segue.destination.
            if let detailViewController = segue.destination as? EntryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                
                // Pass the selected object to the new view controller.
                let entry = fetchResultsController.object(at: indexPath)
                //let entry = EntryController.shared.entries[indexPath.row]
                detailViewController.entry = entry
            }
        }
    }
}
