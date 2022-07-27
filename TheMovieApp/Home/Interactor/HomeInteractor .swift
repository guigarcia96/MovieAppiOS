//
//  HomeInteractor .swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 26/06/22.
//

import Foundation

protocol HomeBusinessLogic {
    func fetchGenres(request: HomeUseCases.HomeView.Request)
}

public class HomeInteractor {
    
    let presenter: HomePresenterPresentationLogic
    let worker: HomeWorkerProtocol
    
    init(presenter: HomePresenterPresentationLogic, worker: HomeWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
}

extension HomeInteractor: HomeBusinessLogic {
    func fetchGenres(request: HomeUseCases.HomeView.Request) {
        presenter.presentGenres(response: .loading)
        worker.loadGenres { [weak self] result in
            switch result {
            case .success(let genres):
                self?.presenter.presentGenres(response: .loaded(.init(genres: genres)))
            case .failure(let error):
                self?.presenter.presentGenres(response: .error(error))
            }
        }
    }
    
    
}
