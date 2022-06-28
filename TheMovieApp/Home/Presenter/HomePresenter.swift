//
//  HomePresenter.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 26/06/22.
//

import Foundation

protocol HomePresenterPresentationLogic: AnyObject {
    func presenteGenres(response: HomeUseCases.HomeView.Response)
}


public class HomePresenter: HomePresenterPresentationLogic {
    weak var view: HomeViewDisplayLogic?
    
    func presenteGenres(response: HomeUseCases.HomeView.Response) {
        view?.displayCategories(viewModel: .init(genres: response.genres))
    }
    
}
