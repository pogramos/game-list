//
//  ScreenshotsCollectionViewCell.swift
//  Game List
//
//  Created by Guilherme Ramos on 09/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class ScreenshotsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!

    func configImage(withData data: Data) {
        imageView.image = UIImage(data: data)
        activityIndicator.stopAnimating()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
}
