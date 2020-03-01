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
 * `EditReminderView.swift` | `RemindMe`
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar/>
 * - Since: Sunday, February 16, 2020
 * - Version: 1.0.0
 */
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
