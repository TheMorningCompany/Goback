//
//  NotesTableViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/10/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            title = "Notes"
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        }
    }
    
    var noteItems:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NotesItem")
        do {
            noteItems = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }
    }
    
    func save(contents: String) {
        let entity = NSEntityDescription.entity(forEntityName: "NotesItem", in: context)
        let noteItem = NSManagedObject(entity: entity!, insertInto: context)
        noteItem.setValue(contents, forKey: "contents")
        do {
            try context.save()
            noteItems.append(noteItem)
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    var context: NSManagedObjectContext! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return noteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteItem = noteItems[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = noteItem.value(forKey: "contents") as! String
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(noteItems[indexPath.row])
            noteItems.remove(at: indexPath.row)
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save: \(error), \(error.userInfo)")
            }
            tableView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
