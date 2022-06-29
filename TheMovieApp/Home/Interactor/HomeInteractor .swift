//
//  HomeInteractor .swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 26/06/22.
//

import Foundation

protocol HomeBusinessLogic {
    func fetchGenres()
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
    func fetchGenres() {
        presenter.presenteGenres(response: .loading)
        worker.loadGenres { [weak self] genres in
            switch genres {
            case .success(let genres):
                self?.presenter.presenteGenres(response: .loaded(.init(genres: genres)))
            case .failure(let error):
                self?.presenter.presenteGenres(response: .error(error))
            }
        }
    }
    
    
}
