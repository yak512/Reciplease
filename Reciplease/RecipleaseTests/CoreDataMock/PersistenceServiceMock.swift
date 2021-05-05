//
//  PersistenceServiceMock.swift
//  Reciplease
//
//  Created by Yakoub on 12/03/2021.
//  Copyright © 2021 Yakoub. All rights reserved.
//

import Foundation
import CoreData

class PersistenceServiceTest: PersistenceService {
    
    override init() {
      super.init()

      let persistentStoreDescription = NSPersistentStoreDescription()
      persistentStoreDescription.type = NSInMemoryStoreType

      let container = NSPersistentContainer(name: "Reciplease")
      container.persistentStoreDescriptions = [persistentStoreDescription]
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
    }
}
