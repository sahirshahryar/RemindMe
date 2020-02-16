//
//  ContentView.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 1/16/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

import SwiftUI
import CoreData

public struct ReminderStack: View {

    @State var topReminder: Reminder
    @State var bottomReminder: Reminder

    public var body: some View {
        VStack(spacing: 10) {
            ReminderView(reminder: topReminder)
            ReminderView(reminder: bottomReminder)
        }
    }

}

public struct ReminderList: View {

    @State var reminders: FetchedResults<Reminder>
    @State var heading: String

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            // if self.reminders.count < 5 {
                HStack(spacing: 10) {
                    ForEach(self.reminders, id: \.self) { rem in
                        ReminderView(reminder: rem)
                    }
                }.padding([.leading, .trailing], 24)

            // OMITTED FUNCTIONALITY: Making the reminders list two units tall
            // if there are 5 or more reminders. Unfortunately this layout takes the
            // SwiftUI compiler too long to type-check, so I'll skip it for now.
            /* } else {
                HStack(spacing: 10) {
                    ForEach(0 ..< ceil(CGFloat(self.reminders.count) / 2.0)) { i in
                        ReminderStack(topReminder: self.reminders[i * 2],
                                      bottomReminder: self.reminders[(i * 2) + 1])
                    }
                }
                .padding(.leading, 24)
            } */
        }
        .frame(width: UIScreen.main.bounds.size.width,
               height: nil, alignment: .leading)
    }

}

public struct ContentView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    // @Environment(\.colorScheme) var theme

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
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.medium)
                    .frame(width: UIScreen.main.bounds.size.width, height: nil,
                           alignment: .leading)
                    .padding(.leading, 44)

                ReminderList(reminders: self.reminders, heading: "HERE & NOW")
            }
            .padding(.top, 12)
            .navigationBarTitle("What's next?", displayMode: .large)
            .background(
                Image("background").resizable()
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
