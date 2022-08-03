//
//  HomePresenter.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 26/06/22.
//

import Foundation

protocol HomePresenterPresentationLogic: AnyObject {
    func presentGenres(response: HomeUseCases.HomeView.Response)
}

public class HomePresenter: HomePresenterPresentationLogic {
    weak var view: HomeViewDisplayLogic?

    func presentGenres(response: HomeUseCases.HomeView.Response) {
        switch response {
        case .loading:
            view?.displayCategories(viewModel: .loading)
        case .loaded(let data):
            view?.displayCategories(viewModel: .loaded(.init(genres: data.genres)))
        case .error:
            let emptyState = EmptyState.withError(and: view)
            view?.displayCategories(viewModel: .error(emptyState))
        }
    }

}
