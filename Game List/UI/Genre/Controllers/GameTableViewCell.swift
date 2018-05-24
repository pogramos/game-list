//
//  GameTableViewCell.swift
//  Game List
//
//  Created by Guilherme Ramos on 13/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    var imageData: Data?
    static var name: String {
        return String(describing: GameTableViewCell.self)
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var summaryWrapperView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    class func nib() -> UINib {
        return UINib(nibName: name, bundle: .main)
    }

    func configCell(for game: Game) {
        titleLabel.text = game.name
        releaseLabel.text = "Release date: \(date(with: game.first_release_date))"

        if let summary = game.summary {
            summaryLabel.text = summary
        } else {
            summaryWrapperView.isHidden = true
        }
    }

    func date(with number: Int64?) -> String {
        if let number = number, let interval = TimeInterval(exactly: number / 1000) {
            let date = Date(timeIntervalSince1970: interval)
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return ""
    }
}
