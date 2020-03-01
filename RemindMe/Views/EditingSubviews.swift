//
//  EditingSubviews.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 2/22/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

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
