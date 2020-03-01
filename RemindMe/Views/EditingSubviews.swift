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
 * `EditingSubviews.swift` | `RemindMe`
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar/>
 * - Since: Saturday, February 22, 2020
 * - Version: 1.0.0
 */
import SwiftUI

/**
 * ChecklistView
 */
struct ChecklistView: View {

    

    var body: some View {
        Text("")
    }
}

struct ChecklistItemView: View {
    var body: some View {
        Text("")
    }
}

/**
 *
 */
struct Collapser: View {

    @State var expanded = false

    @Binding var reminder: Reminder
    let contents: CollapserContent

    init(reminder: Binding<Reminder>, contents: CollapserContent) {
        self._reminder = reminder
        self.contents = contents
    }

    var body: some View {
        // Add collapsing component
        VStack {
            Text("yo")
            if expanded {
                self.contents.contents()
            }
        }
    }
}

/**
 * Represents the contents of a `Collapser`
 */
protocol CollapserContent {
    /**
     * The collapser's heading, which is always shown to the left. This is basically
     * the title of the collapser.
     */
    func label() -> String

    /**
     * A text description of the collapser's contents. This is shown when the collapser
     * is closed.
     */
    func textDescription() -> String

    /**
     * The actual UI within the collapser.
     */
    func contents() -> AnyView
}

struct CategorySelector: CollapserContent {

    /**
     * Current category, bound to the existing reminder
     */
    @Binding var category: Category

    func label() -> String {
        return "category"
    }

    func textDescription() -> String {
        return self.category.name ?? "Unnamed"
    }

    func contents() -> AnyView {
        return AnyView(CategoryListView(selectionBinding: $category))
    }
}

struct LocationSelector: CollapserContent {
    func label() -> String {
        return "Location"
    }

    func textDescription() -> String {
         return "yo"
    }

    func contents() -> AnyView {
        return AnyView(
            HStack {
                Text("Hi")
            }
        )
    }
}


struct ScheduleSelector: CollapserContent {
    func label() -> String {
        return "schedule"
    }

    func textDescription() -> String {
         return "yo"
    }

    func contents() -> AnyView {
        return AnyView(
            HStack {
                Text("Hi")
            }
        )
    }
}

struct AlertSelector: CollapserContent {
    func label() -> String {
        return "alert"
    }

    func textDescription() -> String {
         return "yo"
    }

    func contents() -> AnyView {
        return AnyView(
            HStack {
                Text("Hi")
            }
        )
    }
}




#if DEBUG
//struct EditingSubviews_Previews: PreviewProvider {
//    static var previews: some View {
//        EditingSubviews()
//    }
//}
#endif
