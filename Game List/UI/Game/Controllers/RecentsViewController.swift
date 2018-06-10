//
//  RecentsViewController.swift
//  Game List
//
//  Created by Guilherme Ramos on 02/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class RecentsViewController: ReusableUITableViewController {
    override var segueIdentifier: String { return "recentsToGameSegue" }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ReusableGamesViewModel("recents", sortDescriptors: [NSSortDescriptor(key: "favorite", ascending: false)])
        hero.isEnabled = true
        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchGames()
        tableView.reloadData()
    }

    private func configUI() {
        tableView.backgroundView = EmptyStateView(frame: tableView.frame)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GameViewController {
            if let indexPath = sender as? IndexPath, let game = viewModel.game(at: indexPath) {
                controller.viewModel = GameViewModel(core: game)
            }
        }
    }
}

extension RecentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: indexPath)
    }
}
