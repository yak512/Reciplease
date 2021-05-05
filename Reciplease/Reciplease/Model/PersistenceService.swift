//
//  PersistenceService.swift
//  Reciplease
//
//  Created by yakoub on 03/10/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {

    public init() {}

    public lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    public var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Core Data Saving support
     func saveContext () {
        let context = persistentContainer.viewContext
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
