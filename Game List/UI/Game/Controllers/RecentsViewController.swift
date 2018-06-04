//
//  RecentsViewController.swift
//  Game List
//
//  Created by Guilherme Ramos on 02/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class RecentsViewController: UIViewController {
    let viewModel = RecentsViewModel("recents", sortDescriptors: [])

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchGames()
        tableView.reloadData()
    }

    private func configUI() {
        registerCells()
        tableView.backgroundView = EmptyStateView(frame: tableView.frame)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    private func registerCells() {
        tableView.register(ReusableGameTableViewCell.nib(), forCellReuseIdentifier: ReusableGameTableViewCell.name)
    }
}

extension RecentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = viewModel.numberOfRows()
        tableView.backgroundView?.isHidden = rows > 0
        return rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableGameTableViewCell.name, for: indexPath) as? ReusableGameTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = ReusableGameModel(game: viewModel.game(at: indexPath))
        cell.config()
        return cell
    }
}
