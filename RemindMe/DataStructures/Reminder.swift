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
 * `Reminder.swift` | `RemindMe`
 *
 * Useful methods for the Reminder CoreData object.
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar/>
 * - Since: Monday, February 17, 2020
 * - Version: 1.0.0
 */
import SwiftUI
import Foundation

extension Reminder {

    /**
     * Generates a timely description for this reminder. For example, if a reminder is
     * due by 12:00 AM tomorrow, this method could return "by midnight".
     *
     * To display as much relevant information as possible within the constraints
     * imposed by the application, we use the knapsack algorithm. Not every string of
     * text that we *can* display to the user is equally useful; for example, it could
     * be more useful to tell the user a reminder is "due now" or is "0.3 mi away"
     * than to show "alert set" or "1 subtask remaining". By using the knapsack algorithm,
     * with arbitrarily decided values (i.e., *I* decide what's most important, although
     * we could make it so the user can choose what to prioritize in a later update) and
     * weights being the lengths of the strings, we can show the most valuable information
     * to the user dynamically.
     */
    func getSubtitle(maxWidth: Int) -> String {
        var potentialResults: [(item: String, weight: Int, value: Int)] = []

        func strWidth(_ str: String) -> Int {
            let size: CGSize = str.size(withAttributes: ReminderCard.subtitleFont)
            return Int(ceil(size.width))
        }

        // Populate `potentialResults`
        // TODO

        // return knapsack()

        let bestFit = knapsack(objects: potentialResults, maxWeight: maxWidth)
        return " • ".join(bestFit.map({ $0.item }))
    }
    
}
