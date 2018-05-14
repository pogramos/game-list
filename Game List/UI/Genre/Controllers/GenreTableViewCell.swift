//
//  GenreTableViewCell.swift
//  Game List
//
//  Created by Guilherme on 5/6/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var label: UILabel!

    var viewModel: GenreTableViewCellViewModel!

    fileprivate func configureCard() {
        card.layer.cornerRadius = 2
        card.layer.shadowOpacity = 0.5
        card.layer.shadowOffset = CGSize(width: 0, height: 1)
        card.layer.shadowRadius = 2
    }

    func configureCell() {
        label.text = viewModel.title
        configureCard()
    }
}
