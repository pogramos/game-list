//
//  GCDBlackBox.swift
//  Game List
//
//  Created by Guilherme Ramos on 13/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

func performUIOnMainThread(_ completionHandler: @escaping () -> Void) {
    DispatchQueue.main.async {
        completionHandler()
    }
}
