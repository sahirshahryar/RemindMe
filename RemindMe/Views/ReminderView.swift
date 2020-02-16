//
//  ReminderView.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 1/17/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

import Foundation
import SwiftUI

struct Checkbox: View {

    @Binding var enabled: Bool

    private func toggle() {
        self.enabled.toggle()
    }

    public var body: some View {
        Button (action: toggle) {
            Image(systemName: enabled ? "checkmark.square" : "square")
        }
    }

}

/**
 * UI element for an item within a list
 */
struct ReminderView: View {

    @State var reminder: Reminder

    public var body: some View {
        let completeness = Binding<Bool>(
            get: {
                return self.reminder.complete
            },

            set: {
                self.reminder.complete = $0
                print("New value for reminder \(self.reminder.title!) = \($0)")
            }
        )

        return HStack {
            Checkbox(enabled: completeness)
            VStack {
                Text(self.reminder.title ?? "Untitled")
                Text(self.reminder.desc ?? "No description")
            }
        }
        .frame(width: 150, height: 80, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.init(UIColor.systemGray6))
        )
    }

}
