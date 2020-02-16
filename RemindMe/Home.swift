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
    @Environment(\.colorScheme) var theme

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
            ScrollView {
                /**
                 * First, show the reminders that are can be completed nearby AND
                 * are due soon.
                 */
                Text("HERE & NOW")
                    .font(.system(.body, design: .rounded))
                    .frame(width: UIScreen.main.bounds.size.width, height: nil,
                           alignment: .leading)
                    .padding(.leading, 44)


                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        // TODO: Limit these reminders to only ones deemed "here & now"
                        ForEach(0..<self.reminders.count) {
                            ReminderView(reminder: self.reminders[$0])
                        }
                    }
                    .padding(.leading, 24)
                }.frame(width: UIScreen.main.bounds.size.width,
                        height: nil, alignment: .leading)
            }

            .navigationBarTitle("What's next?", displayMode: .large)
            .background(
                theme == .dark ?
                    Image("background").resizable()
                        .frame(width: UIScreen.main.bounds.size.width * 3, height: UIScreen.main.bounds.size.height + 120, alignment: .center)
                        .blur(radius: 10)
                    : Image("background-light").resizable()
                        .frame(width: UIScreen.main.bounds.size.width * 3, height: UIScreen.main.bounds.size.height + 120, alignment: .center)
                        .blur(radius: 10)
            )

        }
    }
}

/* struct ContentView_Previews: PreviewProvider {
   // @Binding static var reminder: Reminder?

    static var previews: some View {

    }
} */
