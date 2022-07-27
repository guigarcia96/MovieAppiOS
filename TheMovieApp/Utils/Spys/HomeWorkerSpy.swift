//
//  HomeWorkerSpy.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 15/07/22.
//

import Foundation

public final class HomeWorkerSpy: HomeWorkerProtocol {
    
    private (set) var loadGenresCalled = false
    var contentToBeReturned: GenresRequestResult?
    func loadGenres(completion: @escaping GenresRequestCompletion) {
        loadGenresCalled = true
        if let result = contentToBeReturned {
            completion(result)
        }
    }
}
