//
//  DatabaseLayer.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 1/17/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

// see reference article
// https://medium.com/flawless-app-stories/cracking-the-tests-for-core-data-15ef893a3fee
public class PersistenceManager {

    let container: NSPersistentContainer

    lazy var background: NSManagedObjectContext = {
        return self.container.newBackgroundContext()
    }()

    init(cont: NSPersistentContainer) {
        self.container = cont
        // self.container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func createReminder(title: String, description: String = "",
                        dueDate: ScheduleSpecification? = nil,
                        geofence: CLRegion? = nil) -> Reminder? {
        guard let reminder = NSEntityDescription
            .insertNewObject(forEntityName: "Reminder", into: background) as? Reminder else {
                return nil
        }

        reminder.complete = false
        reminder.title = title
        reminder.desc = description

        // print(reminder)

        return reminder
    }

    static func demoPM() -> PersistenceManager {
        let model = NSManagedObjectModel.mergedModel(from: [Bundle(for: PersistenceManager.self)])
        let container = NSPersistentContainer(name: "demo", managedObjectModel: model!)

        let desc = NSPersistentStoreDescription()
        desc.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [desc]

        container.loadPersistentStores(completionHandler: { (desc, error) in
            // do nothing ATM
        })

        return PersistenceManager(cont: container)
    }

    static func manufacture(text: String) -> Reminder {
        return demoPM().createReminder(title: text)!
    }

}
