//
//  GenreViewController.swift
//  Game List
//
//  Created by Guilherme on 5/6/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit
import Hero

class GenreViewController: UIViewController {
    fileprivate let genreCell = "GenreCell"
    fileprivate let segueIdentifier = "genreToGameSegue"
    fileprivate let customTransition = HeroTransition()

    @IBOutlet weak var tableView: UITableView!

    let viewModel = GenreViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        Loader.show(on: self)
        viewModel.delegate = self
        viewModel.fetchGenres()
        hero.isEnabled = true
        navigationController?.delegate = self
        navigationController?.hero.navigationAnimationType = .autoReverse(presenting: .zoom)
    }

    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }

    private func registerCell() {
        tableView.register(GenreTableViewCell.nib(), forCellReuseIdentifier: GenreTableViewCell.name)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let controller = segue.destination as? GamesViewController {
            guard let senderCell = sender as? GenreTableViewCell, let genre = senderCell.genre else {
                return
            }
            controller.viewModel = GamesViewModel(with: genre)
        }
    }
}

extension GenreViewController: ControllersProtocol {
    func updateUI() {
        Loader.hide()
        tableView.reloadData()
    }

    func showErrorOnUI(_ message: String) {
        Dialog.show(on: self, withTitle: "Error", text: message)
    }
}

extension GenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: tableView.cellForRow(at: indexPath))
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.name, for: indexPath) as? GenreTableViewCell else {
            return
        }
    }
}

extension GenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.name, for: indexPath) as? GenreTableViewCell else {
            return UITableViewCell()
        }
        if let genre = viewModel.genre(at: indexPath.row) {
            cell.config(with: genre)
        }
        return cell
    }
}

extension GenreViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return customTransition.navigationController(navigationController, interactionControllerFor: animationController)
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customTransition.navigationController(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
    }
}
