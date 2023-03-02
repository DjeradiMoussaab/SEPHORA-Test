//
//  PersistenceManager.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import CoreData

struct PersistenceManager {
    
    static let shared = PersistenceManager()
    
    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SEPHORA")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        PersistenceManager.shared.container.viewContext
    }
    
    func saveContext () {
        let context = PersistenceManager.shared.container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
