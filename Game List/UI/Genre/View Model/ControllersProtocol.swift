//
//  ControllersProtocol.swift
//  Game List
//
//  Created by Guilherme Ramos on 05/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

protocol ControllersProtocol: class {
    /// Tells the delegate to update the viewController's UI
    func updateUI()

    /// Tells the delegate to show a dialog for the current viewcontroller
    /// indicating that the operation failed, sending the message
    ///
    /// - Parameter message: Message returned by a operation failure
    func showErrorOnUI(_ message: String)
}
