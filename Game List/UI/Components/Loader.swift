//
//  Loader.swift
//  Game List
//
//  Created by Guilherme Ramos on 13/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class Loader {
    static let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    static let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    fileprivate static func setupActivityIndicator() {
        blurredView.contentView.addSubview(indicator)
        indicator.center = blurredView.center
        indicator.startAnimating()
    }

    class func show(on viewController: UIViewController?) {
        if viewController != nil {
            blurredView.frame = viewController!.view.bounds

            setupActivityIndicator()

            viewController!.view.addSubview(blurredView)
        }

    }

    class func hide() {
        blurredView.removeFromSuperview()
    }
}
