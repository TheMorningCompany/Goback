//
//  CoreDataStack.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/28/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "Todos")
        container.loadPersistentStores { (description, error) in
            guard error == nil else {
                print("error: \(String(describing: error))")
                return
            }
        }
        return container
    }
    
    var managedContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    
}
