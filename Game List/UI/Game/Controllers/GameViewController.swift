//
//  GameViewController.swift
//  Game List
//
//  Created by Guilherme Ramos on 27/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit
import Hero

class GameViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var storylineLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: GameViewModel!

    var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var titleStackView: UIStackView!

    class func instance() -> Self {
        return instance(from: "Game", identifier: String(describing: self.self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    // MARK: layout

    func configUI() {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.release
        storylineLabel.text = viewModel.summary
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        viewModel.fetchImage { (data) in
            self.activityIndicator.stopAnimating()
            if let imgData = data {
                self.imageView.image = UIImage(data: imgData)
            }
        }
    }
}
