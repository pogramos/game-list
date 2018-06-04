//
//  GenreSectionHeader.swift
//  Game List
//
//  Created by Guilherme Ramos on 16/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

protocol GenreSectionHeaderDelegate: class {

    /// Tells the delegate the section header was tapped
    ///
    /// - Parameter index: selected uiview tag
    func didSelectSectionHeader(_ sectionHeader: GenreSectionHeader, at index: NSInteger)
}

class GenreSectionHeader: UITableViewHeaderFooterView {
    @IBOutlet weak private var cardView: CardUIView!
    @IBOutlet weak private var arrowImageView: UIImageView!

    weak var delegate: GenreSectionHeaderDelegate!
    var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelection(_:)))
        self.gestureRecognizers = [tapGesture]
    }

    @objc @IBAction private func handleSelection(_ recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view {
            self.delegate.didSelectSectionHeader(self, at: view.tag)
        }
    }

    private func color(expanded: Bool) -> UIColor {
        if expanded {
            return .flatNavyBlue()
        } else {
            return .flatWhite()
        }
    }
    func header(expanded: Bool) {
        tintColor = color(expanded: !expanded)
        titleLabel.textColor = color(expanded: !expanded)
        cardView.backgroundColor = color(expanded: expanded)
        arrowImageView.image = expanded ? #imageLiteral(resourceName: "collapse-arrow") : #imageLiteral(resourceName: "expand-arrow")
    }
}
