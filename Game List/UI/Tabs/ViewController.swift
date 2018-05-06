//
//  ViewController.swift
//  Game List
//
//  Created by Guilherme on 5/5/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let parameters = Parameters([
            "fields": "id,name" as AnyObject
            ])
//        IGDBApi.getGenres(with: parameters, success: { (genres) in
//            print(genres ?? "")
//        }, failure: { (error) in
//            print(error)
//        })
    }
}
