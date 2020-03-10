//
//  Extensions.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 2/29/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

import SwiftUI

public func ceilint(_ val: Double) -> Int {
    return Int(ceil(val))
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
