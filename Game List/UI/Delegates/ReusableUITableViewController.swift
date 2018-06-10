//
//  DataSourceDelegate.swift
//  Game List
//
//  Created by Guilherme Ramos on 09/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class ReusableUITableViewController: UIViewController {
    var segueIdentifier: String {
        return ""
    }
    var viewModel: ReusableGamesViewModel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }

    func numberOfRows(in section: Int) -> Int {
        let rows = viewModel.numberOfRows()
        tableView.backgroundView?.isHidden = rows > 0
        return rows
    }
    func config(_ cell: ReusableGameTableViewCell, at indexPath: IndexPath) {
        cell.viewModel = ReusableGameModel(game: viewModel.game(at: indexPath))
        cell.config()
    }

    private func registerCells() {
        tableView.register(ReusableGameTableViewCell.nib(), forCellReuseIdentifier: ReusableGameTableViewCell.name)
    }
}

extension ReusableUITableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gameTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReusableGameTableViewCell.name, for: indexPath) as? ReusableGameTableViewCell else {
            fatalError("Could not dequee cell for indexPath: \(indexPath)")
        }
        config(gameTableViewCell, at: indexPath)

        return gameTableViewCell
    }
}
