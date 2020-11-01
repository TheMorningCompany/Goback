//
//  NoteTableViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 3/1/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController {

    // MARK: - Properties
    
    var resultsControllerNotes: NSFetchedResultsController<Notes>!
    let coreDataStackNotes = CoreDataStackNotes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide tabBar shadow
        self.tabBarController!.tabBar.layer.borderWidth = 0.50
        self.tabBarController!.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
        self.navigationController!.navigationBar.layer.borderWidth = 0.50
        self.navigationController!.navigationBar.layer.borderColor = UIColor.clear.cgColor
        self.navigationController?.navigationBar.clipsToBounds = true
        
        let requestNotes: NSFetchRequest<Notes> = Notes.fetchRequest()
        let sortDescriptorsNotes = NSSortDescriptor(key: "date", ascending: true)
        
        
        
        requestNotes.sortDescriptors = [sortDescriptorsNotes]
        resultsControllerNotes = NSFetchedResultsController(fetchRequest: requestNotes, managedObjectContext: coreDataStackNotes.managedContextNotes, sectionNameKeyPath: nil, cacheName: nil
        )
        resultsControllerNotes.delegate = self
        
        do {
            try resultsControllerNotes.performFetch()
        } catch {
            print("perform fetch error: \(error)")
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        let note = resultsControllerNotes.object(at: indexPath)
        cell.textLabel?.text = note.title
        cell.textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: UIFont.labelFontSize)
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultsControllerNotes.sections?[section].numberOfObjects ?? 0
        
        
    }
    
    // MARK: TableViewDelelgate

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let note = self.resultsControllerNotes.object(at: indexPath)
            self.resultsControllerNotes.managedObjectContext.delete(note)
            do {
                try self.resultsControllerNotes.managedObjectContext.save()
                completion(true)
            } catch {
                print("delete failed: \(error)")
                completion(false)
            }
            
        }
        action.image = UIImage(systemName: "trash")?.withTintColor(.green, renderingMode: .alwaysTemplate)
        action.backgroundColor = UIColor(named: "BG")
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAddNote", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = sender as? UIBarButtonItem, let vcNotes = segue.destination as? AddNoteViewController {
            vcNotes.managedContextNotes = resultsControllerNotes.managedObjectContext
        }
        
        if let cell = sender as? UITableViewCell, let vcNotes = segue.destination as? AddNoteViewController {
            vcNotes.managedContextNotes = resultsControllerNotes.managedObjectContext
            if let indexPath = tableView.indexPath(for: cell) {
                let note = resultsControllerNotes.object(at: indexPath)
                vcNotes.note = note
            }
        
        }
    }
    
    
}

extension NoteTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .middle)
            }
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .top)
            }
        case.update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) {
                let note = resultsControllerNotes.object(at: indexPath)
                cell.textLabel?.text = note.title
            }
        default:
            break
        }
    }
}
