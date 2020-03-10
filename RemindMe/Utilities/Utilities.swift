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
 * `Utilities.swift` | `RemindMe`
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar/>
 * - Since: Tuesday, March 10, 2020
 */
import Foundation

/**
 * Implementation of the knapsack algorithm, which is used to maximize the value of
 * objects being "carried" within a certain weight limit.
 */
public func knapsack<T>(objects: [(item: T, weight: Int, value: Int)],
                        maxWeight: Int) -> [(item: T, value: Int)] {
    var weights = [[Int]](
        repeating: [Int] (repeating: 0, count: maxWeight + 1), count: objects.count + 1
    )

    var traceback = [[(k: Int, W: Int)]](
        repeating: [(k: Int, W: Int)](repeating: (k: 0, W: 0), count: maxWeight + 1),
        count: objects.count + 1
    )

    // Populate dynamic programming table for knapsack problem
    let maxK = objects.count
    for W in 1 ... maxWeight {
        for k in 1 ... maxK {
            let newObject = objects[k - 1]
            var cellValue = weights[k - 1][W]
            var source = (k: k - 1, W: W)

            if W - newObject.weight >= 0 {
                let alternateCell = weights[k - 1][W - newObject.weight] + newObject.value
                // NOTE: we use >, not >= so that we prefer to show the more important
                // thing rather than a number of less-important things
                if alternateCell > cellValue {
                    cellValue = alternateCell
                    source = (k: k - 1, W: W - newObject.weight)
                }
            }

            weights[k][W] = cellValue
            traceback[k][W] = source
        }
    }

    // Perform traceback
    var results: [(item: T, value: Int)] = []

    var k = maxK
    var W = maxWeight
    while k > 0 {
        let cell = traceback[k][W]

        // Ascended diagonally
        if W != cell.W {
            let insertion = objects[k - 1]
            results.append((item: insertion.item, value: insertion.value))
        }

        k = cell.k
        W = cell.W
    }

    return results.sorted(by: { $0.value > $1.value })
}
