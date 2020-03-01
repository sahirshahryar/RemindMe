//
//  ZStackModalDemo.swift
//  RemindMe
//
//  Created by Sahir Shahryar on 2/17/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

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
