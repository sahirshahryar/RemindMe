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
 * `ReminderCard.swift` | `RemindMe`
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar>
 * - Since: Tuesday, March 10, 2020
 */
import SwiftUI

struct ReminderCard: View {

    public static let subtitleFont
        = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)]

    @State var newReminder: Bool
    @Binding var reminder: Reminder
    @ObservedObject var presentation: CardPresentationDetails

    var body: some View {
        Card(handler: presentation) { expanded in
            // Checkbox and reminder title
            HStack {
                if self.newReminder {
                    // This is a bit clunky, but I suppose it works
                    OnExpand(controlledBy: expanded) {
                        Checkbox(enabled: self.$reminder.complete)
                    }
                    OnExpand(controlledBy: expanded, showWhenCollapsedInstead: true) {
                        Image("new-reminder")
                    }
                } else {
                    Checkbox(enabled: self.$reminder.complete)
                }
            }

            // Metadata controls (only shown when expanded)
            OnExpand(controlledBy: expanded) {
                Text("")
            }

            // Subtitle (only shown when collapsed)
            OnExpand(controlledBy: expanded, showWhenCollapsedInstead: true) {
                // TODO: Explicitly read maxWidth value using GeometryReader
                Text(self.reminder.getSubtitle(maxWidth: 50))
            }
        }
    }

}

struct Checkbox: View {

    /**
     * Actual connection to data model; this allows data to stay in sync with what
     * is shown on-screen
     */
    @Binding var enabled: Bool

    /**
     * "Fake" state variable to force SwiftUI to refresh the view when clicked
     */
    @State var innerState: Int = 0

    @Environment(\.sizeCategory) var size

    let feedback = UIImpactFeedbackGenerator()

    /**
     * Toggles button status and increments `innerState` to force a UI refresh
     */
    private func flip() {
        self.enabled.toggle()
        self.innerState += 1
        feedback.impactOccurred()
    }

    /**
     * Defines checkbox
     */
    public var body: some View {
        Button (action: flip) {
            Image(enabled ? "checkbox-on" : "checkbox-off")
                .renderingMode(.original)
        }
            .frame(width: nil, height: nil, alignment: .topLeading)
            .padding(.top, 0)
            .padding([.leading, .trailing], 6)
    }

}

//struct Reminder_Previews: PreviewProvider {
//    static var previews: some View {
//        Reminder()
//    }
//}
