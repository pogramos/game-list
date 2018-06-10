//
//  ReusableGameTableViewCell.swift
//  Game List
//
//  Created by Guilherme Ramos on 02/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit
import Chameleon

class ReusableGameTableViewCell: UITableViewCell {
    var viewModel: ReusableGameModel?

    @IBOutlet weak var titleBarView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: HeartButton!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var cardView: CardUIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        favoriteColor(for: favoriteButton)

        if let titleBarColor = titleBarView.backgroundColor {
            contrastTitle(with: titleBarColor)
        }

        if let cardColor = cardView.backgroundColor {
            contrastSummary(with: cardColor)
        }
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        cardSelection(for: highlighted)
        super.setHighlighted(highlighted, animated: animated)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        cardSelection(for: selected)
        super.setSelected(selected, animated: animated)
    }

    fileprivate func contrastTitle(with titleBarColor: UIColor) {
        let contrastColor = ContrastColorOf(titleBarColor, returnFlat: true)
        titleLabel.textColor = contrastColor
        favoriteButton.borderColor = contrastColor
    }

    fileprivate func contrastSummary(with cardColor: UIColor) {
        let contrastColor = ContrastColorOf(cardColor, returnFlat: true)
        summaryLabel.textColor = contrastColor
    }

    fileprivate func favoriteColor(for button: HeartButton) {
        if let viewModel = viewModel {
            button.filled = viewModel.favorite
        } else {
            button.filled = false
        }
    }

    fileprivate func cardSelection(for state: Bool) {
        if state {
            titleBarView.backgroundColor = .white
            contrastTitle(with: .white)
            cardView.backgroundColor = .flatNavyBlueColorDark()
            contrastSummary(with: .flatNavyBlueColorDark())
        } else {
            cardView.backgroundColor = .white
            contrastSummary(with: .white)
            titleBarView.backgroundColor = .flatNavyBlueColorDark()
            contrastTitle(with: .flatNavyBlueColorDark())
        }
    }

    func config() {
        hero.isEnabled = true
        if let data = viewModel?.image, let image = UIImage(data: data) {
            bgImageView.image = image
        } else {
            bgImageView.image = #imageLiteral(resourceName: "default-image")
        }
        titleLabel.text = viewModel?.title
        summaryLabel.text = viewModel?.summary
    }
}
