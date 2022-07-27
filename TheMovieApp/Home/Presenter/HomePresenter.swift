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
        case .error(let error):
            let emptyState = EmptyState.with(error: error, buttonDelegate: view)
            view?.displayCategories(viewModel: .error(emptyState))
        }
    }
    
}
