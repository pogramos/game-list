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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        let name = String(describing: GenreSectionHeader.self)
        let headerNib = UINib(nibName: name, bundle: .main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: name)
    }

    @objc func expandSection(sender: UIGestureRecognizer) {
    }
}

extension GenreViewController: GenreViewModelDelegate {
    func updateUI(with indexSet: IndexSet) {
        Loader.hide()
        tableView.reloadSections(indexSet, with: .fade)
    }

    func updateUI() {
        Loader.hide()
        tableView.reloadData()
    }

    func showErrorOnUI(_ message: String) {
        Dialog.show(on: self, text: message)
    }
}

extension GenreViewController: GenreSectionHeaderDelegate {
    func didSelectSectionHeader(at index: NSInteger) {
        Loader.show(on: self.tabBarController)
        viewModel.fetchGames(for: index)
    }
}

extension GenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: GenreSectionHeader.self)) as? GenreSectionHeader else {
            return nil
        }
        header.delegate = self
        header.tag = section
        header.titleLabel.text = viewModel.genreTitle(at: section)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.game(at: indexPath)?.name
        return cell
    }
}
