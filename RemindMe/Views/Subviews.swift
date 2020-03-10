//
//  Subviews.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 3/10/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

import SwiftUI

struct Group<C: View>: View {

    var contents: () -> C

    init(@ViewBuilder _ contents: @escaping () -> C) {
        self.contents = contents
    }

    var body: some View {
        return self.contents()
    }

}

struct OnExpand<C: View>: View {

    var contents: () -> C

    @Binding var expanded: Bool

    let negate: Bool

    init(controlledBy: Binding<Bool>, showWhenCollapsedInstead negate: Bool = false,
         @ViewBuilder _ contents: @escaping () -> C) {
        self._expanded = controlledBy
        self.negate = negate
        self.contents = contents
    }

    var body: some View {
        return (self.expanded != self.negate) ? AnyView(self.contents())
            : AnyView(EmptyView())
    }

}
