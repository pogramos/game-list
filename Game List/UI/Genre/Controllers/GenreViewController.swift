//
//  GenreViewController.swift
//  Game List
//
//  Created by Guilherme on 5/6/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var viewModel: GenreViewModel = {
        return GenreViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        Loader.show(on: self)
        viewModel.delegate = self
        viewModel.fetchGenres()
    }

    func registerCells() {
        tableView.register(UINib(nibName: viewModel.cellIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.cellIdentifier)
    }
}

extension GenreViewController: GenreViewModelDelegate {
    func updateUI() {
        tableView.reloadData()
        Loader.hide()
    }

    func showErrorOnUI(_ message: String) {
        Dialog.show(on: self, text: message)
    }
}

extension GenreViewController: UITableViewDelegate {
    
}

extension GenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier) as? GenreTableViewCell {
            cell.viewModel = GenreTableViewCellViewModel(with: viewModel.genre(at: indexPath))
            cell.configureCell()
            return cell
        }
        return UITableViewCell()
    }
}
