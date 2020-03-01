//
//  Reminder.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 2/17/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

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
import Foundation

extension Reminder {

    /**
     * Generates a timely description for this reminder. For example, if a reminder is
     * due by 12:00 AM tomorrow, this method could return "by midnight".
     */
    func getSubtitle(maxWidth: Int) -> String {
        return ""
    }
    
}
