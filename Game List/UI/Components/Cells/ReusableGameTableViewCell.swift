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

    override func layoutSubviews() {
        super.layoutSubviews()
        favoriteColor(for: favoriteButton)
    }

    func config() {
        if let data = viewModel?.image, let image = UIImage(data: data) {
            bgImageView.image = image
        } else {
            bgImageView.image = #imageLiteral(resourceName: "default-image")
        }
        titleLabel.text = viewModel?.title
        summaryLabel.text = viewModel?.summary
        let contrastingColor = ContrastColorOf(titleBarView.backgroundColor!, returnFlat: true)
        titleLabel.textColor = contrastingColor
        favoriteButton.borderColor = contrastingColor
    }

    fileprivate func favoriteColor(for button: HeartButton) {
        if let viewModel = viewModel {
            button.filled = viewModel.favorite
        } else {
            button.filled = false
        }
    }
}
