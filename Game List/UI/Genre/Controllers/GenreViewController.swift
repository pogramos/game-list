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

    @objc func showAlert(sender: GenreSectionHeader) {
        var message = "Mensagem"
        if let index = sender.index {
            let genre = viewModel.genre(at: IndexPath(row: 0, section: index))
            message = genre.name!
        }
        let alertController = UIAlertController(title: "Genero", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension GenreViewController: GenreViewModelDelegate {
    func updateUI(section: Int) {
        
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
        header.index = section
        header.titleLabel.text = viewModel.genreTitle(at: section)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showAlert(sender:)))
        header.gestureRecognizers = [gesture]

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableView.estimatedSectionHeaderHeight
    }
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
