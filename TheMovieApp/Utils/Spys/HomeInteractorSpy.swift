//
//  HomeInteractorSpy.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 13/07/22.
//

import Foundation

public final class HomeInteractorSpy: HomeBusinessLogic {

    private (set) var fetchGenresCalled: Bool = false
    func fetchGenres(request: HomeUseCases.HomeView.Request) {
        fetchGenresCalled = true
    }
}
