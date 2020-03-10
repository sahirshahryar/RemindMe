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
 * `ReminderView.swift` | `RemindMe`
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar/>
 * - Since: Friday, January 17, 2020
 * - Version: 1.0.0
 */
import Foundation
import SwiftUI

/**
 * UI element for an item within a list
 */
struct ReminderView: View {

    @Binding var hidden: Bool

    @State var reminder: Reminder

    // Text size setting for accessibility
    @Environment(\.sizeCategory) var size

    // See ViewControllerAccess.swift.
    @Environment(\.viewController) var vc

    public var body: some View {
        // Binding to connect CoreData object to checkbox
        let completeness = Binding(
            get: { self.reminder.complete },
            set: { self.reminder.complete = $0 }
        )

        // Create the rectangle
        return HStack(alignment: .top, spacing: 2) {
            // Place a checkbox on the left side
            Checkbox(enabled: completeness, innerState: 0)
                .padding(.top, 6)

            // On the right, place the reminder text and description
            VStack(alignment: .leading, spacing: 4) {
                //
                Text(self.reminder.title ?? "Untitled")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 3)
                    .padding(.bottom, -6)

                // Spacer keeps positioning relatively consistent whether the reminder
                // text is 1 or 2 lines.
                Spacer(minLength: 0)

                // This description is manufactured by the application to provide more
                // information.
                Text(self.reminder.desc ?? "")
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                    .padding(.top, -2)
            }
            .padding([.top, .bottom, .trailing], 4)
        }
        .frame(width: width(), height: height(), alignment: .leading)
        .contentShape(Rectangle())
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.init(UIColor.systemGray6))
                .opacity(0.9)
        )
        .onTapGesture {
            self.expand()
        }
        .opacity(self.hidden ? 0 : 1)
    }

    func expand() {
        print("EXPANDING NOW")
        self.hidden = true // TODO: Animate?
        self.vc.vc?.presentSwiftUIView(presentation: .overCurrentContext) {
            EditReminderView(isNew: false, backgroundHidden: $hidden,
                             reminder: self.reminder)
        }
    }

    /**
     * Function to determine reminder height based on accessibility size
     */
    func width() -> CGFloat {
        switch size {
        case .extraSmall:
            return 200
        case .small:
            return 220
        case .medium:
            return 240
        case .large:
            return 260
        case .extraLarge:
            return 280
        case .extraExtraLarge:
            return 300

        /**
         * Right now these size limits are designed around the 375x812 canvas found on
         * the 5.8" X-class iPhones. We artificially limit it to 320 pts so that it is
         * always visible whether there is another reminder in the list (the next one
         * will be barely visible on the right edge of the screen). Any wider and we
         * would not be able to see those. We can make room for additional content by
         * making the reminder *taller*, not wider.
         */
        default:
            return 320
        }
    }

    /**
     * Function to determine reminder height based on accessibility size
     */
    func height() -> CGFloat {
        switch size {
        case .extraSmall:
            return 80
        case .small:
            return 90
        case .medium:
            return 100
        case .large:
            return 110
        case .extraLarge:
            return 120
        case .extraExtraLarge:
            return 130
        case .extraExtraExtraLarge:
            return 140
        case .accessibilityMedium:
            return 160
        case .accessibilityLarge:
            return 180
        case .accessibilityExtraLarge:
            return 200
        case .accessibilityExtraExtraLarge:
            return 220
        case .accessibilityExtraExtraExtraLarge:
            return 250
        @unknown default:
            return 160
        }
    }

}
