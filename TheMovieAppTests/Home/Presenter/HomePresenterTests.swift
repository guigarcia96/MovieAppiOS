//
//  HomePresenterTests.swift
//  TheMovieAppTests
//
//  Created by guilherme.garcia on 18/07/22.
//

import XCTest
@testable import TheMovieApp

class HomePresenterTests: XCTestCase {
    
    let view = HomeViewControllerSpy()
    
    private lazy var sut: HomePresenterPresentationLogic = {
        let presenter = HomePresenter()
        let view = view
        presenter.view = view
        return presenter
    }()
    
    func test_presentGenres_shouldCallDisplayCategoriesAndValueShouldBeLoaded() {
        let genreResult: GenreResult = .fixture()
        let response: HomeUseCases.HomeView.Response = .loaded(.init(genres: genreResult.genres))
        
        sut.presentGenres(response: response)
        
        let expectedResult: HomeUseCases.HomeView.ViewModel = .loaded(.init(genres: genreResult.genres))
        XCTAssertEqual(expectedResult, view.displayCategoriesPassed)
        XCTAssertTrue(view.displayCategoriesCalled)
        
    }
    
    func test_presentGenres_shouldCallDisplayCategoriesAndValueShouldBeLoading() {
        let response: HomeUseCases.HomeView.Response = .loading
        
        sut.presentGenres(response: response)
        
        let expectedResult: HomeUseCases.HomeView.ViewModel = .loading
        XCTAssertEqual(expectedResult, view.displayCategoriesPassed)
        XCTAssertTrue(view.displayCategoriesCalled)
        
    }
    
    func test_presentGenres_shouldCallDisplayCategoriesAndValueShouldBeErrorWithError() {
        let error = createMockError()
        let response: HomeUseCases.HomeView.Response = .error(error)
        
        sut.presentGenres(response: response)
        
        let expectedResult: HomeUseCases.HomeView.ViewModel = .error(.with(error: error, buttonDelegate: view))
        XCTAssertEqual(expectedResult, view.displayCategoriesPassed)
        XCTAssertTrue(view.displayCategoriesCalled)
        
    }
    
    func createMockError() -> Error {
        let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Invalid access token"])
        return error
    }

}

extension HomeUseCases.HomeView.ViewModel: Equatable {
    public static func == (lhs: HomeUseCases.HomeView.ViewModel, rhs: HomeUseCases.HomeView.ViewModel) -> Bool {
        switch (lhs, rhs) {
        case (.loaded(let lhsData), .loaded(let rhsData)):
            return lhsData.genres == rhsData.genres
        case (.loading, .loading):
            return true
        case (.error(let lhsEmptyState), .error(let rhsEmptyState)):
            return lhsEmptyState == rhsEmptyState
        default:
            return false
        }
    }
}


