//
//  Number+Extension.swift
//  Game List
//
//  Created by Guilherme Ramos on 09/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

extension Int64 {
    func toDateString() -> String {
        let interval = TimeInterval(self) / 1000
        let date = Date(timeIntervalSince1970: interval)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
