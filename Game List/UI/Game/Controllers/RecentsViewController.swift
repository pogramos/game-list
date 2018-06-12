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
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ReusableGamesViewModel("recents", sortDescriptors: [NSSortDescriptor(key: "favorite", ascending: false)])
        hero.isEnabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchGames()
        tableView.reloadData()
        configUI()
    }

    private func configUI() {
        setupSearchController()
        if viewModel.numberOfRows() == 0 {
            tableView.backgroundView = EmptyStateView(frame: tableView.frame)
        }
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    private func setupSearchController() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GameViewController {
            if let indexPath = sender as? IndexPath, let game = viewModel.game(at: indexPath) {
                controller.viewModel = GameViewModel(core: game)
            }
        }
    }
}

extension RecentsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filter(by: searchController.searchBar.text)
        tableView.reloadData()
    }
}

extension RecentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: indexPath)
    }
}
