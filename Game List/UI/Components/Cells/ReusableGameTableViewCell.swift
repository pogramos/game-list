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

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var summaryLabel: UILabel!

    func config() {
        let defaultColor = contentView.backgroundColor ?? .white
        var contrastingColor = ContrastColorOf(defaultColor, returnFlat: true)
        if let data = viewModel?.image, let image = UIImage(data: data) {
            contrastingColor = ContrastColorOf(AverageColorFromImage(image), returnFlat: true)
            bgImageView.image = UIImage(data: data)
        } else {
            bgImageView.alpha = 0
        }

        titleLabel.text = viewModel?.title
        titleLabel.textColor = contrastingColor
        summaryLabel.text = viewModel?.summary
        summaryLabel.textColor = contrastingColor
    }

    fileprivate func setFavoriteImage(for button: UIButton) {
        if let fav = viewModel?.favorite {
            let img: UIImage = fav ? #imageLiteral(resourceName: "heart") : #imageLiteral(resourceName: "empty-heart")
            button.setImage(img, for: .normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "empty-heart"), for: .normal)
        }
    }
}
