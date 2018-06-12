//
//  UICarouselViewLayout.swift
//  Game List
//
//  Created by Guilherme Ramos on 09/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit
class UICarouselViewLayout: UICollectionViewFlowLayout {
    var centerInset: CGFloat = 0.0

    convenience init(withCenterInset centerInset: CGFloat) {
        self.init()
        self.centerInset = centerInset
    }

    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }

        itemSize = collectionView.frame.size
        itemSize.width -= (2 * centerInset)

        scrollDirection = .horizontal
        collectionView.isPagingEnabled = true

        minimumLineSpacing = 0.0
        minimumInteritemSpacing = 0.0

        sectionInset = UIEdgeInsets(top: 0.0, left: centerInset, bottom: 0.0, right: centerInset)
        footerReferenceSize = CGSize.zero
        headerReferenceSize = CGSize.zero
    }
}
