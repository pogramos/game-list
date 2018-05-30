//
//  GameTableViewCell.swift
//  Game List
//
//  Created by Guilherme Ramos on 13/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

fileprivate enum Code: String, CustomStringConvertible {
    case unavailable_summary

    var description: String {
        return self.rawValue.localized()
    }
}

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

    func configCell(for game: Game) {
        titleLabel.text = game.name
        releaseLabel.text = "Release date: \(date(with: game.first_release_date))"
        summaryLabel.text = game.summary ?? Code.unavailable_summary.description
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
