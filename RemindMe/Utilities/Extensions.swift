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
 * `Extensions.swift` | `RemindMe`
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar>
 * - Since: Saturday, February 29, 2020
 */
import SwiftUI

public func ceilint(_ val: Double) -> Int {
    return Int(ceil(val))
}

public func notNil(_ values: Any?...) -> Bool {
    for val in values {
        if val == nil {
            return false
        }
    }

    return true
}

extension String {

    func join(_ array: [String]) -> String {
        if array.count == 0 {
            return ""
        }

        var result = array[0]

        for i in 1 ..< array.count {
            result += self + array[i]
        }

        return result
    }

}



/**
 * Represents a `Bool` value for which several disparate binding can be created. This
 * class would not be necessary if we could simply write an extension to the `Bool` class;
 * alas, the `set:` portion of the resultant binding mutates the boolean value, which
 * the Swift compiler doesn't like very much.
 */
class SharedBool {

    /**
     * The value of this `SharedBool`.
     */
    var state: Bool


    /**
     * Initialize this `SharedBool` with the given value, or `false` if none is
     * supplied.
     *
     * - parameter startState: (`Bool = false`) the initial value of this `SharedBool`.
     */
    init(_ startState: Bool = false) {
        self.state = false
    }


    /**
     * Generates a new binding for this `SharedBool`.
     */
    var bind: Binding<Bool> {
        return Binding(
            get: { self.state },
            set: { self.state = $0 }
        )
    }


    /**
     * Generates an array with as many `SharedBool`s as requested, with the specified
     * default value (or `false` if none is given).
     *
     * - Parameters:
     *   - len: (`Int`) the length of the resultant array.
     *   - def: (`Bool = false`) the default value of each item in the array.
     */
    static func array(_ len: Int, def: Bool = false) -> [SharedBool] {
        var result: [SharedBool] = []

        for _ in 0 ..< len {
            result.append(SharedBool(def))
        }

        return result
    }
}
