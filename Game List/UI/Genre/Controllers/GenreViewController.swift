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
    let genreCell = "GenreCell"
    let segueIdentifier = "genreToGameSegue"

    @IBOutlet weak var tableView: UITableView!

    let viewModel = GenreViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        Loader.show(on: self)
        viewModel.delegate = self
        viewModel.fetchGenres()
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
