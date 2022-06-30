//
//  HomeWorker.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 26/06/22.
//

import Foundation
import Alamofire

typealias GenresRequestResult = Result<[Genre], AFError>
typealias GenresRequestCompletion = (GenresRequestResult) -> Void

protocol HomeWorkerProtocol {
    func loadGenres(completion: GenresRequestCompletion?)
}

final class HomeWorker: HomeWorkerProtocol {
    func loadGenres(completion: GenresRequestCompletion?) {
        let parameters: Parameters = ["api_key": "6dac0fd5c85431d1c5643511b0f35c71", "language": "pt-BR"]
        URLCache.shared.removeAllCachedResponses()
        AF.request("https://api.themoviedb.org/3/genre/movie/list", method: .get, parameters: parameters).validate(statusCode: 200..<300).responseDecodable(of: GenreResult.self) { response in
            switch response.result {
            case .success(let genreResult):
                completion?(.success(genreResult.genres))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    
}
