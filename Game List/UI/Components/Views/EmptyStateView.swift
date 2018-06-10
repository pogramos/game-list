//
//  EmptyStateView.swift
//  Game List
//
//  Created by Guilherme Ramos on 03/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var textLabel: UILabel!

    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    public var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configUI()
    }

    private func configUI() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
