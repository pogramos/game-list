//
//  GameViewController.swift
//  Game List
//
//  Created by Guilherme Ramos on 27/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit
import Hero
import Chameleon

class GameViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var storylineLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var favoriteButton: HeartButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!

    var viewModel: GameViewModelProtocol!

    class func instance() -> Self {
        return instance(from: "Game", identifier: String(describing: self.self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.modalAnimationType = .selectBy(presenting: .zoomSlide(direction: .up), dismissing: .slide(direction: .up))
        configUI()
    }

    // MARK: layout

    func configUI() {
        let gradientColors: [UIColor] = [
            UIColor.flatWhite(),
            UIColor.flatWhite().withAlphaComponent(0),
            UIColor.clear
        ]
        navigationBar.backgroundColor = GradientColor(.topToBottom, frame: navigationBar.frame, colors: gradientColors)
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.release
        storylineLabel.text = viewModel.summary
        favoriteColor(for: favoriteButton)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        viewModel.fetchImage { (data) in
            self.activityIndicator.stopAnimating()
            if let imgData = data, let image = UIImage(data: imgData) {
                self.imageView.image = image
            }
        }
    }

    // MARK: Action
    fileprivate func favoriteColor(for button: HeartButton) {
        if let viewModel = viewModel {
            button.filled = viewModel.favorite
        } else {
            button.filled = false
        }
    }

    @IBAction func favoriteAction(_ sender: HeartButton) {
        viewModel.toggleFavorite()
        favoriteColor(for: sender)
    }

}
