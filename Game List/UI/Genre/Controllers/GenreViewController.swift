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
//        tableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.name)

        let name = String(describing: GenreSectionHeader.self)
        let headerNib = UINib(nibName: name, bundle: .main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: name)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GameViewController, let cell = sender as? GameTableViewCell {
            if let indexPath = tableView.indexPath(for: cell), let game = viewModel.game(at: indexPath) {
                controller.viewModel = GameViewModel(with: game)
            }
        }
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
        Dialog.show(on: self, withTitle: "Error", text: message)
    }
}

extension GenreViewController: GenreSectionHeaderDelegate {
    func didSelectSectionHeader(at index: NSInteger) {
        Loader.show(on: self.tabBarController)
        viewModel.toggle(section: index)
    }
}

extension GenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: GenreSectionHeader.self)) as? GenreSectionHeader else {
            return nil
        }
        header.delegate = self
        header.tag = section
        header.titleLabel.text = viewModel.genre(at: section)?.name
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.name) as? GameTableViewCell {
            if let game = viewModel.game(at: indexPath) {
                cell.configCell(for: game)
            }
            return cell
        }
        return UITableViewCell()
    }
}
