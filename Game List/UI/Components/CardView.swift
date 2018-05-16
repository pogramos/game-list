//
//  CardView.swift
//  Game List
//
//  Created by Guilherme Ramos on 16/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.3, height: 2)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 3
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.2
    }
}
