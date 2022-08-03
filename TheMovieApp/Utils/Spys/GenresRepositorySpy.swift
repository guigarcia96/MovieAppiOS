//
//  GenresRepositorySpy.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 19/07/22.
//

import Foundation

public final class GenresRepositorySpy: GenresRepositoryProtocol {

    private (set) var getGenresCalled = false
    var contentToBeReturned: GenresRequestResult?
    func getGenres(completion: @escaping GenresRequestCompletion) {
        getGenresCalled = true
        if let result = contentToBeReturned {
            completion(result)
        }
    }
}
