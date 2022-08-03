//
//  HomeViewController.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 25/05/22.
//

protocol HomeViewDisplayLogic: EmptyStateViewDelegate {
    func displayCategories(viewModel: HomeUseCases.HomeView.ViewModel)
}

import UIKit

class HomeViewController: UIViewController {

    let customView: HomeViewDisplay
    let interactor: HomeBusinessLogic

    private var viewModel: HomeUseCases.HomeView.ViewModel.Data?

    init(customView: HomeViewDisplay = HomeView(), interactor: HomeBusinessLogic) {
        self.customView = customView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = customView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchGenres()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.tableViewDelegate = self
        customView.tableViewDataSource = self
    }

    private func fetchGenres() {
        interactor.fetchGenres(request: .init())
    }

}

// MARK: HomeDisplayLogic

extension HomeViewController: HomeViewDisplayLogic {

    func emptyStateViewButtonTouched(forState emptyState: EmptyState) {
        fetchGenres()
    }

    func displayCategories(viewModel: HomeUseCases.HomeView.ViewModel) {
        switch viewModel {
        case .loading:
            customView.transition(toState: .loading)
        case .loaded(let data):
            self.viewModel = data
            customView.transition(toState: .content)
        case .error(let emptyState):
            customView.transition(toState: .empty(emptyState), animated: true)
        }
    }

}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.genres.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        guard let genres = viewModel?.genres else { return UITableViewCell() }
        let genre = genres[indexPath.row]
        cell.display(viewModel: .init(genreName: genre.name))
        return cell
    }
}
