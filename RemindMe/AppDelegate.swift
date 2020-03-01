/*
 * This file is part of RemindMe, licensed under the MIT License (MIT).
 *
 * Copyright © Sahir Shahryar <https://github.com/sahirshahryar/>
 * This program is built as part of a personal portfolio, and will not necessarily
 * be maintained by its author.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

/**
 * `AppDelegate.swift` | `RemindMe`
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar/>
 * - Since: Thursday, January 16, 2020
 * - Version: 1.0.0
 */
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /**
     * Fetcher for the `NSPersistentContainer` that we use to store reminder data,
     * schedules, categories, et cetera.
     */
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


    /**
     * Gets the currently active `AppDelegate` singleton.
     */
    static func get() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }


    /**
     * Gets the `NSManagedObjectContext` of the persistence model for reads / writes.
     */
    static func getContext() -> NSManagedObjectContext {
        return AppDelegate.get().persistentContainer.viewContext
    }


    /**
     * Attempts to save any changes to the data model to disk.
     *
     * - Returns: `(Bool)` `true` if the save was successful or if no changes have been
     *            made since the last write; `false` if and only if there was an error
     *            while trying to save changes.
     */
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


    /**
     *
     */
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {
            // Override point for customization after application launch.
            return true
    }


    // MARK: UISceneSession Lifecycle
    /**
     *
     */
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }


    /**
     *
     */
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running,
        // this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded
        // scenes, as they will not return.
    }

}

