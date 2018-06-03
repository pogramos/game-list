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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var storylineLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var favoriteButton: UIButton!

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
        if let backgroundColor = view.backgroundColor {
            backButton.tintColor = ContrastColorOf(backgroundColor, returnFlat: true)
        }
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.release
        storylineLabel.text = viewModel.summary
        setFavoriteImage(for: favoriteButton)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        viewModel.fetchImage { (data) in
            self.activityIndicator.stopAnimating()
            if let imgData = data, let image = UIImage(data: imgData) {
                self.imageView.image = image
                self.backButton.tintColor = ContrastColorOf(AverageColorFromImage(image), returnFlat: true)
            }
        }
    }

    // MARK: Action
    fileprivate func setFavoriteImage(for button: UIButton) {
        if viewModel.favorite {
            button.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "empty-heart"), for: .normal)
        }
    }

    @IBAction func favoriteAction(_ sender: UIButton) {
        viewModel.toggleFavorite()
        setFavoriteImage(for: sender)
    }

}
