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
        let cellNib = UINib(nibName: viewModel.cellIdentifier, bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: viewModel.cellIdentifier)

        let name = String(describing: GenreSectionHeader.self)
        let headerNib = UINib(nibName: name, bundle: .main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: name)
    }

    @objc func expandSection(sender: UIGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        Loader.show(on: self.tabBarController)
        viewModel.fetchGames(for: view.tag)
    }
}

extension GenreViewController: GenreViewModelDelegate {
    func updateUI(with indexSet: IndexSet) {
        tableView.reloadSections(indexSet, with: .fade)
    }

    func updateUI() {
        tableView.reloadData()
        Loader.hide()
    }

    func showErrorOnUI(_ message: String) {
        Dialog.show(on: self, text: message)
    }
}

extension GenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: GenreSectionHeader.self)) as? GenreSectionHeader else {
            return nil
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(expandSection(sender:)))
        header.tag = section
        header.titleLabel.text = viewModel.genreTitle(at: section)
        header.gestureRecognizers = [gesture]
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableView.estimatedSectionHeaderHeight
    }
}

extension GenreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
