//
//  TabViewController.swift
//  Game List
//
//  Created by Guilherme Ramos on 03/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit
import Chameleon

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        tabBar.tintColor = UIColor.flatNavyBlueColorDark()
    }
}
