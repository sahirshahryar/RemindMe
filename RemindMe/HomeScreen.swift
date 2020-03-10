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
 * `HomeScreen.swift` | `RemindMe`
 *
 * - Authors: Sahir Shahryar <https://github.com/sahirshahryar/>
 * - Since: Monday, March 9, 2020
 */
import SwiftUI
import Foundation

/**
 * 
 */
struct PrimaryContentView: View {

    /**
     * Whether or not a card is currently being presented right now.
     */
    @State var cardPresented = false

    /**
     * The details of the card view that is about to be presented to the
     * user.
     */
    @ObservedObject var presentationDetails = CardPresentationDetails.empty
    
    var body: some View {
        ZStack {
            background
            if cardPresented {
                cardStage
            } else {
                primaryStage
            }
        }
    }

    var background: some View {
        Image("background").resizable()
        .frame(width: UIScreen.main.bounds.size.width * 3,
               height: UIScreen.main.bounds.size.height + 120,
               alignment: .center)
        .blur(radius: 10)
    }

    var primaryStage: some View {
        Text("i am")
    }

    var cardStage: some View {
        Card(handler: self.presentationDetails) { expanded in
            OnExpand(controlledBy: expanded) {
                Text("T")
            }.onTapGesture {
                self.presentationDetails.destination = nil
            }
        }
    }

}


/**
 * A class containing all the details for presenting a card to the user.
 */
class CardPresentationDetails: ObservableObject {

    /**
     * The initial position of the top-left corner of the card that will be
     * presented in isolation. The card view will start at this position
     * in its collapsed state.
     */
    var origin: CGPoint?

    /**
     * The final position of the top-left corner of the card that will be
     * presented in isolation. The card view will expand into its full size
     * and pan into this position from `origin` simultaneously.
     */
    var destination: CGPoint?

    /**
     * The actual view to be presented. This should be a `Card`, but there
     * is technically nothing preventing it from being one.
     *
     * When first presenting this view, it should be identical in appearance
     * to the currently-presented card. A simple cross-dissolve animation should
     * give the appearance of all other UI elements fading out of view while keeping
     * the tapped card intact. From there, because the collapsed card technically
     * contains all of the blank spaces for the "expanded view-only" UI elements,
     * animating the transition from collapsed to expanded card should be extremely
     * simple.
     */
    var view: AnyView?

    init(startingPoint origin: CGPoint?,
         endingPoint destination: CGPoint?,
         presentedView view: AnyView?) {
        self.origin = origin
        self.destination = destination
        self.view = view
    }

    static let empty = CardPresentationDetails(startingPoint: nil,
                                               endingPoint: nil,
                                               presentedView: nil)

}


/**
 * 
 */
struct Card<C: View>: View {

    var contents: (Binding<Bool>) -> C

    @State var expanded = false

    @ObservedObject var presentationDetails: CardPresentationDetails

    init(handler presentationDetails: CardPresentationDetails,
         @ViewBuilder _ contents: @escaping (Binding<Bool>) -> C) {
        self.presentationDetails = presentationDetails
        self.contents = contents
    }

    var body: some View {
        let binding = Binding(
            get: { self.expanded },
            set: { self.expanded = $0 }
        )
        return self.contents(binding).onTapGesture {
            self.presentationDetails.view = AnyView(self)
        }
    }

    func expand() {
        self.expanded = true
    }

}

protocol CardPopulator {
    func contents(forIndex index: Int) -> AnyView
}

class CardSection {
    var heading: String
    var populator: CardPopulator

    init(title: String = "", cards: CardPopulator) {
        self.heading = title
        self.populator = cards
    }

    public func cardFor(_ index: Int) -> AnyView {
        return AnyView(populator.contents(forIndex: index))
    }
}



#if DEBUG
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryContentView()
    }
}
#endif
