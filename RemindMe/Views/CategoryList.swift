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
 * `CategoryList.swift` | `RemindMe`
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar/>
 * - Since: Saturday, February 29, 2020
 * - Version: 1.0.0
 */
import SwiftUI

/**
 * One of the coolest things I've found thus far in SwiftUI is using
 * `@Binding` and `@State` to automate the selection / deselection of
 * mutually exclusive controls (e.g., buttons in a radio group).
 *
 * A `RadioPill` is a pill-shaped button in a radio group. This control
 * is used primarily to switch between categories of reminders.
 */
struct RadioPill: View {

    /**
     * The text being displayed within the pill.
     */
    @State var label: String


    /**
     * The index of this selection within the broader radio group.
     */
    @State var index: Int


    /**
     * The global selection index. When this button is tapped, we will
     * set the value of `selection` to `index`, and this information will
     * be sent to each of the other buttons in the radio group. In effect,
     * this is less efficient than, say, running the following pseudocode:
     *
     * ```
     * buttons[currentSelection].setColor(UIColor.systemGray5)
     * currentSelection = tappedButtonIndex
     * buttons[currentSelection].setColor(UIColor.blue)
     * ```
     *
     * The above code runs in constant time, whereas the SwiftUI code sends
     * updates to each of the the `n - 2` buttons that don't need them.
     * However, one must also consider the cool factor of doing it the SwiftUI
     * way. No doubt: SwiftUI's way is just cooler.
     */
    @Binding var selection: Int


    /**
     * `View` code for this `RadioPill`.
     */
    var body: some View {
        Text(self.label)
            .background(
                RoundedRectangle(cornerRadius: 10)
                .fill(
                    Color.init(self.selection == self.index ? UIColor.blue : UIColor.systemGray5)
                )
            )
            .onTapGesture {
                self.selection = self.index
                // ... that's all there is to it!
            }
    }

}

/**
 * Represents the entire radio group for selecting which category is on
 * display (or which category a reminder belongs to).
 */
struct CategoryListView: View {

    /**
     * Get all categories from CoreData.
     */
    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Category.name, ascending: true)
        ]
    ) var categories: FetchedResults<Category>


    /**
     * Todo: default to closest `Category`. (This will likely happen in
     * `SceneDelegate.swift`.)
     */
    @State var selIndex: Int = 0


    /**
     * `Binding` for the currently selected `Category`. Sent to each `RadioPill`
     * to let them each update the selection independently.
     */
    @Binding var selection: Category

    
    /**
     * Initializes this `CategoryListView`.
     * - Parameter selectionBinding: The `Binding` to which updates to the
     *                               user's selection should be sent.
     */
    init(selectionBinding: Binding<Category>) {
        self._selection = selectionBinding

        /**
         * To the best of my knowledge, `FetchRequest`s are not retrieved
         * until some time before `self.body` is accessed, but well after
         * `init()` has actually been called.
         */
    }


    /**
     * Generate view for `CategoryListView`.
     */
    var body: some View {
        let indexBinding = Binding(
            get: { self.selIndex },
            set: {
                self.selIndex = $0
                self.selection = self.categories[$0]
            }
        )

        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0 ..< categories.count) { i in
                    RadioPill(label: self.categories[i].name ?? "unnamed",
                              index: i,
                              selection: indexBinding)
                }
            }
        }
    }
}

//struct CategoryList_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryList()
//    }
//}
