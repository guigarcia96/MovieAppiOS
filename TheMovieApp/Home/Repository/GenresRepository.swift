//
//  GenresRepository.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 19/07/22.
//

import Foundation
import Alamofire

protocol GenresRepositoryProtocol {
    func getGenres(completion: @escaping GenresRequestCompletion)
}

public final class GenresRepository: GenresRepositoryProtocol {
    func getGenres(completion: @escaping GenresRequestCompletion) {
        let parameters: Parameters = ["api_key": "6dac0fd5c85431d1c5643511b0f35c71", "language": "pt-BR"]
        URLCache.shared.removeAllCachedResponses()
        AF.request("https://api.themoviedb.org/3/genre/movie/list", method: .get, parameters: parameters).validate(statusCode: 200..<300).responseDecodable(of: GenreResult.self) { response in
            switch response.result {
            case .success(let genreResult):
                completion(.success(genreResult.genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
