//
//  EditReminderView.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 2/16/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

import Foundation
import SwiftUI

/**
 * View for editing details of a reminder
 *
 * See https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/DefiningCustomPresentations.html#//apple_ref/doc/uid/TP40007457-CH25-SW1
 *
 *
 */
public struct EditReminderView: View {

    /**
     * `isNew` is passed with
     */
    let isNew: Bool

    @Binding var backgroundHidden: Bool

    /**
     * Variable for whether expansion animation is complete. Not currently used
     */
    @State var expanded = false

    @State var reminder: Reminder?

    @Environment(\.viewController) var vc

    public var body: some View {
        let completeness = Binding(
            get: { self.reminder?.complete ?? false },
            set: { self.reminder?.complete = $0 }
        )

        let titleBinding = Binding(
            get: { self.reminder?.title ?? "" },
            set: { self.reminder?.title = $0 }
        )

        let descBinding = Binding(
            get: { self.reminder?.desc ?? "" },
            set: { self.reminder?.desc = $0 }
        )

        // Create the rectangle
        return VStack {
            HStack(alignment: .top, spacing: 2) {
                // Place a checkbox on the left side
                Checkbox(enabled: completeness, innerState: 0)
                    .padding(.top, 6)

                // On the right, place the reminder text and description
                VStack(alignment: .leading, spacing: 4) {
                        // Transform Text into TextField
                        TextField(self.isNew ? "newReminder" : "reminderTitle",
                                  text: titleBinding)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            // .fontWeight(.semibold)
                            .lineLimit(expanded ? nil : 2)
                            .fixedSize(horizontal: false, vertical: false)
                            .padding(.top, 3)
                            .padding(.bottom, -6)

                    .padding([.top, .bottom, .trailing], 4)
                }
            }
            .padding(.bottom, 4)

            TextField("description", text: descBinding)
                .padding([.leading, .trailing], 12)

            Spacer(minLength: 0)

            // Temporary button to close the view
            Button(
                action: {
                    self.exit()
                },
                label: {
                    Text("Close")
                }
            )
        }
        .frame(width: width(), height: height(), alignment: .leading)
        .contentShape(Rectangle())
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.init(UIColor.systemGray6))
                .opacity(0.9)
        )
    }

    func width() -> CGFloat {
        return 340
    }

    func height() -> CGFloat {
        return 400
    }

    func exit() {
        self.backgroundHidden = false
        self.vc.vc?.dismiss(animated: true)
    }

}
