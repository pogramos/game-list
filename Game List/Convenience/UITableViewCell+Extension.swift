//
//  UITableViewCell+Extension.swift
//  Game List
//
//  Created by Guilherme Ramos on 02/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var name: String {
        return String(describing: self.self)
    }
    class func nib() -> UINib? {
        return UINib(nibName: name, bundle: nil)
    }
}
