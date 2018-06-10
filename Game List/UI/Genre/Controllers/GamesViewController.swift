//
//  GamesViewController.swift
//  Game List
//
//  Created by Guilherme Ramos on 04/06/2018.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    fileprivate let kBottomLoadMoreDistance: CGFloat = 10.0
    fileprivate var activityIndicator: UIActivityIndicatorView!
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var emptyView: UIStackView = UIStackView()

    var viewModel: GamesViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        Loader.show(on: self)
        viewModel.fetchGames()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
            navigationController?.isNavigationBarHidden = true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GameViewController, let cell = sender as? GameTableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                let game = viewModel.game(at: indexPath)
                controller.viewModel = GameViewModel(game: game)
            }
        }
    }

    private func configUI() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true
        tableView.tableFooterView = activityIndicator
        setupNavigationBar()
    }

    private func configEmptyView() {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "No games were returned on your search"
        label.sizeToFit()

        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.addTarget(viewModel, action: #selector(viewModel.fetchGames), for: .touchUpInside)

        emptyView.addArrangedSubview(label)
        emptyView.addArrangedSubview(button)
        emptyView.spacing = 8

        tableView.backgroundView = emptyView
    }

    private func setupNavigationBar() {
        navigationItem.title = viewModel.title
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: Controller Protocol Section
typealias UIController = GamesViewController
extension UIController: ControllersProtocol {
    func updateUI() {
        Loader.hide()
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }

    func showErrorOnUI(_ message: String) {
        tableView.reloadData()
        activityIndicator.stopAnimating()
        Dialog.show(on: self, withTitle: "Error", text: message)
    }
}

// MARK: TableView Section
typealias TableViewController = GamesViewController
extension TableViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height
        if (maxOffset - scrollView.contentOffset.y) <= kBottomLoadMoreDistance {
            activityIndicator.startAnimating()
            Loader.show(on: self)
            viewModel.fetchGames()
        }
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = viewModel.numberOfItems()
        tableView.backgroundView?.isHidden = rows > 0
        return rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.name, for: indexPath) as? GameTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(for: viewModel.game(at: indexPath))

        return cell
    }
}
