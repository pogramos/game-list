//
//  CardUIView.swift
//  Game List
//
//  Created by Guilherme Ramos on 16/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit
import Chameleon

@IBDesignable
class CardUIView: UIView {

    let animationDuration: CGFloat = 0.3

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }

    private var storedBackgroundColor: UIColor?
    private var highlightedColor: UIColor? {
        return backgroundColor?.lighten(byPercentage: 10)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    fileprivate func setHighlighted(_ highlighted: Bool) {
        if highlighted {
            storedBackgroundColor = backgroundColor
            backgroundColor = highlightedColor
        } else {
            backgroundColor = storedBackgroundColor
        }
    }

    func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if animated {
            UIView.animate(withDuration: TimeInterval(animationDuration)) {
                self.setHighlighted(highlighted)
            }
        } else {
            setHighlighted(highlighted)
        }
    }
}
