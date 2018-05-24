//
//  ModalComponent.swift
//  Game List
//
//  Created by Guilherme Ramos on 13/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

final class Dialog {
    static let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    // MARK: private methods

    fileprivate static func createLabel(with text: String, size: CGFloat = 16, color: UIColor = .darkGray) -> UILabel {
        let label = UILabel()

        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = text
        label.font = label.font.withSize(size)
        label.textColor = color
        label.textAlignment = .center

        return label
    }

    fileprivate static func createButton() -> UIButton {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true

        button.layer.masksToBounds = true
        button.tintColor = .blue
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(UIColor.blue.withAlphaComponent(0.3), for: .highlighted)

        button.addTarget(self, action: #selector(close), for: .touchUpInside)

        return button
    }

    fileprivate static func buildDialog(with frame: CGRect) -> UIView {
        blurredView.frame = frame

        let size = CGSize(width: blurredView.contentView.frame.width * 0.8, height: CGFloat(200))
        let dialog = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))

        blurredView.contentView.addSubview(dialog)

        dialog.translatesAutoresizingMaskIntoConstraints = false
        dialog.centerXAnchor.constraint(equalTo: blurredView.centerXAnchor).isActive = true
        dialog.centerYAnchor.constraint(equalTo: blurredView.centerYAnchor).isActive = true
        dialog.widthAnchor.constraint(equalToConstant: blurredView.contentView.frame.width * 0.8).isActive = true

        dialog.backgroundColor = .white
        dialog.layer.cornerRadius = 10
        dialog.layer.shadowOpacity = 0.5
        dialog.layer.shadowOffset = CGSize(width: 0, height: 3)
        dialog.layer.shadowRadius = 15

        return dialog
    }

    fileprivate static func createStackView(on dialog: UIView) -> UIStackView {
        let stack = UIStackView(frame: dialog.frame)
        dialog.addSubview(stack)

        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 8

        stack.translatesAutoresizingMaskIntoConstraints = false
        // positive margins, will push the stackview downwards and to the right
        stack.topAnchor.constraint(equalTo: dialog.topAnchor, constant: 8).isActive = true
        stack.leftAnchor.constraint(equalTo: dialog.leftAnchor, constant: 8).isActive = true
        // negative margins, will pull the stack view upwards and to the left
        stack.rightAnchor.constraint(equalTo: dialog.rightAnchor, constant: -8).isActive = true
        stack.bottomAnchor.constraint(equalTo: dialog.bottomAnchor, constant: -8).isActive = true

        return stack
    }

    fileprivate static func animate(_ dialog: UIView) {
        dialog.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
            dialog.transform = CGAffineTransform.identity
        }
        animator.startAnimation()
    }

    @objc fileprivate static func close() {
        blurredView.removeFromSuperview()
    }

    // MARK: exposed methods

    class func show(on viewController: UIViewController) {
        show(on: viewController, withTitle: "Alert", text: "error")
    }

    class func show(on viewController: UIViewController, withTitle: String?, text: String?) {
        let dialog = buildDialog(with: viewController.view.bounds)
        let stack = createStackView(on: dialog)

        if let title = withTitle {
            stack.addArrangedSubview(createLabel(with: title, size: 24))
        }

        if let text = text {
            stack.addArrangedSubview(createLabel(with: text, color: .lightGray))
        }

        stack.addArrangedSubview(createButton())

        animate(dialog)

        viewController.view.addSubview(blurredView)
    }
}
