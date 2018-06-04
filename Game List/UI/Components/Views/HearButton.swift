//
//  UIButton+Heart.swift
//  Game List
//
//  Created by Guilherme Ramos on 03/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

@IBDesignable
class HeartButton: UIButton {
    @IBInspectable
    var borderWidth: CGFloat = 2.0

    @IBInspectable
    var borderColor: UIColor?

    @IBInspectable
    var filledColor: UIColor?

    @IBInspectable
    var filled: Bool = false {
        didSet {
            draw(frame)
        }
    }

    var drawn: Bool = false

    var heart: CAShapeLayer?

    override func awakeFromNib() {
        super.awakeFromNib()
        setFilledColor()
    }

    private func radians(of degree: CGFloat) -> CGFloat {
        return degree * .pi / 180
    }

    private func heartPath(with rect: CGRect) -> UIBezierPath {
        let fourthOfWidth = rect.width * 0.4
        let thirdOfHeight = rect.height * 0.3
        // (a ^ 2 + b ^ 2) / 2
        let arc = sqrt(pow(fourthOfWidth, 2) + pow(thirdOfHeight, 2)) / 2
        let bezierPath = UIBezierPath()
        let arcHeight = rect.height * 0.35
        bezierPath.move(to: CGPoint(x: rect.midX, y: rect.height * 0.85))
        bezierPath.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: arcHeight),
                          radius: arc,
                          startAngle: radians(of: 135),
                          endAngle: radians(of: 315),
                          clockwise: true)
        bezierPath.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
        bezierPath.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: arcHeight),
                          radius: arc,
                          startAngle: radians(of: 225),
                          endAngle: radians(of: 45),
                          clockwise: true)
        bezierPath.addLine(to: CGPoint(x: rect.midX, y: rect.height * 0.85))

        return bezierPath
    }

    private func setFilledColor() {
        if filled {
            if let filledColor = filledColor?.cgColor {
                heart?.fillColor = filledColor
            } else {
                heart?.fillColor = UIColor.clear.cgColor
            }
        } else {
            heart?.fillColor = UIColor.clear.cgColor
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if drawn {
            setFilledColor()
            return
        }
        heart = CAShapeLayer()
        heart?.path = heartPath(with: bounds).cgPath
        heart?.lineWidth = borderWidth
        if let borderColor = borderColor?.cgColor {
            heart?.strokeColor = borderColor
        } else {
            heart?.strokeColor = tintColor.cgColor
        }
        setFilledColor()
        drawn = true
        if let heart = heart {
            layer.addSublayer(heart)
        }
    }
}
