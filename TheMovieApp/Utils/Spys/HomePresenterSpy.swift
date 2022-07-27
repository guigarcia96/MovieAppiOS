//
//  HomePresenterSpy.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 15/07/22.
//

import Foundation


public final class HomePresenterSpy: HomePresenterPresentationLogic {
    
    private (set) var presentGenresCalled: Bool = false
    private (set) var presentGenresPassed: HomeUseCases.HomeView.Response?
    func presentGenres(response: HomeUseCases.HomeView.Response) {
        presentGenresCalled = true
        presentGenresPassed = response
    }
}
