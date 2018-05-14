//
//  String+Extension.swift
//  Game List
//
//  Created by Guilherme Ramos on 12/05/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

extension String {
    subscript (characterOffset: Int) -> String {
        return String(self[self.index(startIndex, offsetBy: characterOffset)])
    }
}
