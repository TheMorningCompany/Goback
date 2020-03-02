//
//  CoreDataStack.swift
//  Goback
//
//  Created by Zeqiel Golomb on 3/1/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStackNotes {
    
    var containerNotes: NSPersistentContainer {
            let containerNotes = NSPersistentContainer(name: "Notes")
            containerNotes.loadPersistentStores { (description, error) in
                guard error == nil else {
                    print("error: \(String(describing: error))")
                    return
                }
            }
            return containerNotes
        }
        
        var managedContextNotes: NSManagedObjectContext {
            return containerNotes.viewContext
        }
        
        
    }
