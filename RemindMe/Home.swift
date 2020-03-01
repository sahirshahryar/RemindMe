//
//  ContentView.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 1/16/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

/**
 * `Home.swift` | `RemindMe`
 *
 * Contains code for the home screen of RemindMe.
 *
 * - Since: Thursday, January 16, 2020
 * - Authors: Sahir Shahryar <sahirshahryar@gmail.com>
 * - Version: 1.0.0
 * - Copyright: © 2020 Sahir Shahryar
 */
import SwiftUI
import CoreData

/**
 * A vertical stack of reminders, meant to be used when there are more
 * than five reminders in any scrolling view of reminders on the home
 * page.
 */
public struct ReminderStack: View {

    /**
     *
     */
    @Binding var hidden: Bool


    /**
     *
     */
    @State var topReminder: Reminder


    /**
     *
     */
    @State var bottomReminder: Reminder?


    /**
     *
     */
    public var body: some View {
        VStack(spacing: 10) {
            ReminderView(hidden: $hidden, reminder: topReminder)

            if bottomReminder != nil {
                ReminderView(hidden: $hidden, reminder: bottomReminder!)
            }
        }
    }

}


/**
 *
 */
public struct ReminderList: View {

    /**
     *
     */
    @Binding var hidden: Bool

    /**
     *
     */
    @State var reminders: FetchedResults<Reminder>


    /**
     *
     */
    @State var heading: String


    /**
     *
     */
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if self.reminders.count < 5 {
                self.horizontalView
            } else {
                self.stackedView
            }
        }
        .frame(width: UIScreen.main.bounds.size.width,
               height: nil, alignment: .leading)
    }


    /**
     *
     */
    private var horizontalView: some View {
        HStack(spacing: 10) {
            ForEach(self.reminders, id: \.self) { rem in
                ReminderView(hidden: self.$hidden, reminder: rem)
            }
        }.padding([.leading, .trailing], 24)
    }

    private var stackedView: some View {
        let stacks = self.stackReminders()

        return HStack(spacing: 10) {
            ForEach(0 ..< stacks.count) { i in
                ReminderStack(hidden: self.$hidden,
                              topReminder: stacks[i].0,
                              bottomReminder: stacks[i].1)
            }
        }
        .padding(.leading, 24)
    }

    private func stackReminders() -> [(Reminder, Reminder?)] {
        var result: [(Reminder, Reminder?)] = []
        
        for i in 0 ..< Int(ceil(Double(self.reminders.count) / 2.0)) {
            var stack: (Reminder, Reminder?) = (self.reminders[i * 2], nil)

            if (i * 2) + 1 < self.reminders.count {
                stack.1 = self.reminders[(i * 2) + 1]
            }

            result.append(stack)
        }

        return result
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

    @State var category: Category

    @State var hidden = false


    public var body: some View {
        let selectionBinding = Binding(
            get: { self.category },
            set: { self.category = $0 }
        )

        return NavigationView {
            ScrollView {
                CategoryListView(selectionBinding: selectionBinding)

                Text(self.category.name ?? "No selection")

                /**
                 * First, show the reminders that are can be completed nearby AND
                 * are due soon.
                 */
                Text("hereAndNow")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.medium)
                    .frame(width: UIScreen.main.bounds.size.width, height: nil,
                           alignment: .leading)
                    .padding(.leading, 44)
                    .opacity(self.hidden ? 0 : 1)

                ReminderList(hidden: $hidden, reminders: self.reminders,
                             heading: "hereAndNow")

                // Text("reminderExclusion \("Home")")
            }
            .padding(.top, 12)
            .navigationBarTitle("titleBar", displayMode: .large)
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
