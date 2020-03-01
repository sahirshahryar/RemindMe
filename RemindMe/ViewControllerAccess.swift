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
 * `ViewControllerAccess.swift` | `RemindMe`
 *
 * - Authors:
 *   Timothy Costa <https://github.com/timothycosta/>
 *   Original source code
 *
 *   Sahir Shahryar <https://github.com/sahirshahryar/>
 *   Adaptation
 *
 * - Since: Monday, February 17, 2020
 * - Version: 1.0.0
 */
import Foundation
import SwiftUI
import UIKit

// See https://gist.github.com/timothycosta/a43dfe25f1d8a37c71341a1ebaf82213
// Code to access UIViewController from SwiftUI by Timothy Costa
// Comments below are my effort to understand what is happening in the code below

// Workaround for rootViewController being nilable (UIViewController*?*)
struct VCHolder {
    weak var vc: UIViewController?
    init(_ vc: UIViewController?) {
        self.vc = vc
    }
}

// Cruft required to allow us to create an environment variable
struct VCKey: EnvironmentKey {
    static var defaultValue: VCHolder {
        return VCHolder(UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: VCHolder {
        get { self[VCKey.self] }
        set { self[VCKey.self] = newValue }
    }
}

extension UIViewController {
    // Add a method to UIViewController
    func presentSwiftUIView<C: View>(presentation: UIModalPresentationStyle = .automatic,
                                     transition: UIModalTransitionStyle = .coverVertical,
                                     animated: Bool = true,
                                     onComplete: @escaping () -> Void = {},
                                     @ViewBuilder _ content: () -> C) {

        // Initialize UIKit's SwiftUI wrapper
        // Set rootView to be of type AnyView because we will replace it with a different
        // view in a moment.
        let bridge = UIHostingController(rootView: AnyView(EmptyView()))
        bridge.modalPresentationStyle = presentation
        bridge.modalTransitionStyle = transition

        /**
         * This is the code that sort of confuses me -- can we just add environment
         * variables arbitrarily?
         */
        bridge.rootView = AnyView(
            content().environment(\.viewController, VCHolder(bridge))
        )

        if presentation == .overCurrentContext {
            bridge.view.backgroundColor = .clear
        }

        self.present(bridge, animated: animated, completion: onComplete)
    }
}
