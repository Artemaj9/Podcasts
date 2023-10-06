//
//  LocalManager.swift
//

import Foundation
import CoreData

struct FavoritesDataManager {
    static let shared = FavoritesDataManager()

    let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "FavoritesDataModel")
        container.loadPersistentStores { description, error in
//            print("DEBUG: database init \(description)")
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
