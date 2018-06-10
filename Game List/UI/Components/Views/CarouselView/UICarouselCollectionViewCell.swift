//
//  UICarouselCollectionViewCell.swift
//  Game List
//
//  Created by Guilherme Ramos on 09/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class UICarouselCollectionViewCell: UICollectionViewCell {
    var minScale: CGFloat = 0.9
    var minAlpha: CGFloat = 0.9
    var scaleDivisor: CGFloat = 10.0

    @IBOutlet var activeCellView: UIView!


    override func layoutSubviews() {
        super.layoutSubviews()
        guard let superCarouselView = superview as? UICarouselView else {
            return
        }
        scale(withInset: superCarouselView.centerInset)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        activeCellView.transform = CGAffineTransform.identity
        activeCellView.alpha = 1
    }

    // 90% scale
    func scale(withInset centerInset: CGFloat = 0.9) {
        guard let superview = superview, let activeCellView = activeCellView else {
            return
        }
        let xPoint = superview.convert(frame, to: nil).origin.x - centerInset
        let scalePercent = fabs(frame.width - fabs(xPoint)) / frame.width
        let scale = minScale + (scalePercent/scaleDivisor)

        activeCellView.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
        activeCellView.alpha = minAlpha * (scalePercent/scaleDivisor)
        activeCellView.layer.cornerRadius = 20
    }
}
