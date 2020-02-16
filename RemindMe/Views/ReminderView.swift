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

    /**
     * Actual connection to data model; this allows data to stay in sync with what
     * is shown on-screen
     */
    @Binding var enabled: Bool

    /**
     * "Fake" state variable to force SwiftUI to refresh the view when clicked
     */
    @State var innerState: Int

    @Environment(\.sizeCategory) var size

    let feedback = UIImpactFeedbackGenerator()

    /**
     * Scale image to match accessibility size. Doesn't work as of right now
     */
    private func scale() -> CGFloat {
        switch size {
        case .large:
            return 1.04
        case .extraExtraLarge:
            return 1.08
        case .extraExtraExtraLarge:
            return 1.12
        case .accessibilityMedium:
            return 1.16
        case .accessibilityLarge:
            return 1.20
        case .accessibilityExtraLarge:
            return 1.24
        case .accessibilityExtraExtraLarge:
            return 1.30
        case .accessibilityExtraExtraExtraLarge:
            return 1.38
        default:
            return 1
        }
    }

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
                // .scaleEffect(scale()) -> TODO: Doesn't do anything right now
        }
            .frame(width: nil, height: nil, alignment: .topLeading)
            .padding(.top, 0)
            .padding([.leading, .trailing], 6)
    }

}

/**
 * UI element for an item within a list
 */
struct ReminderView: View {

    @State var reminder: Reminder
    @Environment(\.sizeCategory) var size

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

    public var body: some View {
        // Binding to connect CoreData object to checkbox
        let completeness = Binding(
            get: { self.reminder.complete },
            set: { self.reminder.complete = $0 }
        )

        //
        return HStack(alignment: .top, spacing: 2) {
            Checkbox(enabled: completeness, innerState: 0)
                .padding(.top, 6)
            VStack(alignment: .leading, spacing: 4) {
                Text(self.reminder.title ?? "Untitled")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 3)
                    .padding(.bottom, -6)
                Spacer(minLength: 0)
                Text(self.reminder.desc ?? "No details")
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                    .padding(.top, -2)
            }
            .padding([.top, .bottom, .trailing], 4)
        }
        .frame(width: width(), height: height(), alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.init(UIColor.systemGray6))
                .opacity(0.9)
        )
    }

}
