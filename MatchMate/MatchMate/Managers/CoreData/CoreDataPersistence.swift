//
//  CoreDataPersistence.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import Foundation
import CoreData

final class CoreDataPersistence {
    static let shared = CoreDataPersistence()
    
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: "MatchMate")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Core Data Error: Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        viewContext.automaticallyMergesChangesFromParent = true
    }
}
