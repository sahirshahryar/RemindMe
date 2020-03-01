//
//  AppDelegate.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 1/16/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RemindersModel")
        container.loadPersistentStores(completionHandler: { desc, errors in
            if let error = errors {
                print("Error detected")
                print(error)
            }
        })

        return container
    }()

    static func getContext() -> NSManagedObjectContext {
        return AppDelegate.get().persistentContainer.viewContext
    }

    static func saveContext() -> Bool {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                // todo: Report error
                return false
            }
        }

        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    static func get() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }


}

