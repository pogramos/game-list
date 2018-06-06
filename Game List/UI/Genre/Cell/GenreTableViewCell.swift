//
//  GenreTableViewCell.swift
//  Game List
//
//  Created by Guilherme Ramos on 05/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    var genre: Genre?
    @IBOutlet weak var genreTitleLabel: UILabel!
    @IBOutlet weak var cardView: CardUIView!

    func config(with genre: Genre) {
        genreTitleLabel.text = genre.name
        self.genre = genre
        hero.isEnabled = true
        hero.modifiers = [.fade, .translate(CGPoint(x: 100, y: 0))]
    }

    fileprivate func cardSelection(for state: Bool) {
        if state {
            cardView.tintColor = .white
            genreTitleLabel.textColor = .white
            cardView.backgroundColor = .flatNavyBlueColorDark()
        } else {
            cardView.backgroundColor = .white
            cardView.tintColor = .flatNavyBlueColorDark()
            genreTitleLabel.textColor = .flatNavyBlueColorDark()
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

}
