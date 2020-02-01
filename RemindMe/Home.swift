//
//  ContentView.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 1/16/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

import SwiftUI
import CoreData

public struct ContentView: View {

    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(entity: Reminder.entity(),
                  sortDescriptors: [
                    NSSortDescriptor(keyPath: \Reminder.title, ascending: true)
                  ],
                  predicate: nil) private var reminders: FetchedResults<Reminder>

    init() {
        /* let request = NSFetchRequest<Reminder>(entityName: "Reminder")
        request.returnsObjectsAsFaults = false

        do {
            let result = try managedObjectContext.fetch(request)
            for data in result {
                print(data.title)
            }
        } catch {

        } */
    }

    public var body: some View {
        NavigationView {
            List (reminders, id: \.self) { reminder in
                ReminderListItem(reminder: reminder)
            }


            .navigationBarTitle("What's next?")
        }
    }
}

/* struct ContentView_Previews: PreviewProvider {
   // @Binding static var reminder: Reminder?

    static var previews: some View {

    }
} */
