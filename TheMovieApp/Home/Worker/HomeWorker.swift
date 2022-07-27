//
//  HomeWorker.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 26/06/22.
//

import Foundation
import Alamofire

typealias GenresRequestResult = Result<[Genre], Error>
typealias GenresRequestCompletion = (GenresRequestResult) -> Void

protocol HomeWorkerProtocol {
    func loadGenres(completion: @escaping GenresRequestCompletion)
}

final class HomeWorker: HomeWorkerProtocol {
    
    let repository: GenresRepositoryProtocol
    
    init(repository: GenresRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadGenres(completion: @escaping GenresRequestCompletion) {
        repository.getGenres { result in
            switch result {
            case .success(let genres):
                completion(.success(genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
