//
//  HomeViewControllerSpy.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 13/07/22.
//

import Foundation

public final class HomeViewControllerSpy: HomeViewDisplayLogic {
    
    private (set) var displayCategoriesCalled: Bool = false
    private (set) var displayCategoriesPassed: HomeUseCases.HomeView.ViewModel?
    func displayCategories(viewModel: HomeUseCases.HomeView.ViewModel) {
        displayCategoriesCalled = true
        displayCategoriesPassed = viewModel
    }
    
    private (set) var emptyStateViewButtonTouchedCalled: Bool = false
    private (set) var emptyStateViewButtonTouchedPassed: EmptyState?
    public func emptyStateViewButtonTouched(forState emptyState: EmptyState) {
        emptyStateViewButtonTouchedCalled = false
        emptyStateViewButtonTouchedPassed = emptyState
    }
    
}
