//
//  UICarouselView.swift
//  Game List
//
//  Created by Guilherme Ramos on 09/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class UICarouselView: UICollectionView {
    private struct CellBound {
        let lower: CGFloat
        let upper: CGFloat

        init(withInset inset: CGFloat) {
            lower = inset - 20
            upper = inset + 20
        }
    }

    var scrollWidthConstraint: NSLayoutConstraint?
    var scrollCenterLeftConstraint: NSLayoutConstraint?
    @IBInspectable
    public var centerInset: CGFloat = 0.0 {
        didSet {
            configUI()
        }
    }

    var centerCell: UICollectionViewCell? {
        let bound = CellBound(withInset: centerInset)
        for cell in visibleCells {
            let rect = convert(cell.frame, to: nil)
            if rect.origin.x > bound.lower && rect.origin.x < bound.upper {
                return cell
            }
        }
        return nil
    }

    var centerCellIndexPath: IndexPath? {
        guard let centerCell = centerCell else {
            return nil
        }

        return indexPath(for: centerCell)
    }

    private lazy var scrollView: UIScrollView! = self.makeScrollView()
    private func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.isUserInteractionEnabled = false
        scrollView.delegate = self
        return scrollView
    }

    override var contentSize: CGSize {
        didSet {
            guard let dataSource = dataSource else {
                return
            }
            let numberOfSections = dataSource.numberOfSections?(in: self) ?? 1
            var numberOfItems = 0
            for index in 0..<numberOfSections {
                numberOfItems += dataSource.collectionView(self, numberOfItemsInSection: index)
            }

            let contentWidth = scrollView.frame.width * CGFloat(numberOfItems)
            scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)
        }
    }

    private func configUI() {
        collectionViewLayout = UICarouselViewLayout(withCenterInset: centerInset)
        configConstraints()
    }

    private func toggleConstraints(_ active: Bool) {
        scrollWidthConstraint?.isActive = active
        scrollCenterLeftConstraint?.isActive = active
    }

    private func configConstraints() {
        toggleConstraints(false)

        scrollWidthConstraint = scrollView.widthAnchor.constraint(equalTo: widthAnchor, constant: -(2 * centerInset))
        scrollCenterLeftConstraint = scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: centerInset)

        toggleConstraints(true)
    }

    private func configScrollView() {
        addGestureRecognizer(scrollView.panGestureRecognizer)
        superview?.addSubview(scrollView)
        scrollView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }

    func didScroll() {
        scrollViewDidScroll(scrollView)
    }
}

extension UICarouselView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffset = scrollView.contentOffset
        for cell in visibleCells {
            if let carouselCell = cell as? UICarouselCollectionViewCell {
                carouselCell.scale(withInset: centerInset)
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)

    }
}
