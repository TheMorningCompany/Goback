//
//  ViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/9/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var todoItems:[NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = fetchData(key: "todoList") {
            todoList = todo
        } else {
            todoList = [String]()
        }
        
        tableView.delegate = self
        
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TodoItem")
        do {
            todoItems = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }
    }
    
    func save(name: String) {
        let entity = NSEntityDescription.entity(forEntityName: "TodoItem", in: context)
        let todoItem = NSManagedObject(entity: entity!, insertInto: context)
        todoItem.setValue(name, forKey: "title")
        do {
            try context.save()
            todoItems.append(todoItem)
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    var context: NSManagedObjectContext! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItem = todoItems[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = todoItem.value(forKey: "title") as! String
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList?.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    
}

