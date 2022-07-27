//
//  HomeViewControllerTests.swift
//  TheMovieAppTests
//
//  Created by guilherme.garcia on 13/07/22.
//

import XCTest
@testable import TheMovieApp

class HomeViewControllerTests: XCTestCase {

    private let view = HomeViewDisplaySpy()
    private let interactor = HomeInteractorSpy()
    private lazy var sut = HomeViewController(customView: view, interactor: interactor)
    
    func test_emptyStateViewButtonTouched_shouldCallFetchGenres() {
        let error = createMockError()
        let emptyStateWithError: EmptyState = .with(error: error, buttonDelegate: sut)
        
        sut.emptyStateViewButtonTouched(forState: emptyStateWithError)
        
        XCTAssertEqual(interactor.fetchGenresCalled, true)
    }
    
    func test_displayCategories_shouldCallAdaptAndAdaptBeCorretWhenIsLoadingState() {
        let viewModel: HomeUseCases.HomeView.ViewModel = .loading
        
        sut.displayCategories(viewModel: viewModel)
        
        XCTAssertEqual(view.adaptCalled, true)
        XCTAssertEqual(view.adaptPassed, .loading)
    }
    
    func test_displayCategories_shouldCallAdaptAndAdaptBeCorretWhenIsError() {
        let error = createMockError()
        let emptyStateWithError: EmptyState = .with(error: error, buttonDelegate: sut)
        let viewModel: HomeUseCases.HomeView.ViewModel = .error(emptyStateWithError)
        
        sut.displayCategories(viewModel: viewModel)
        
        XCTAssertEqual(view.adaptCalled, true)
        XCTAssertEqual(view.adaptPassed, .empty(emptyStateWithError))
        
    }
    
    func test_displayCategories_shouldCallAdaptAndAdaptBeCorretWhenIsContent() {
        let genreResult: GenreResult = .fixture()
        let viewModelData: HomeUseCases.HomeView.ViewModel.Data = .init(genres: genreResult.genres)
        let viewModel: HomeUseCases.HomeView.ViewModel = .loaded(viewModelData)
        
        sut.displayCategories(viewModel: viewModel)
        
        XCTAssertEqual(view.adaptCalled, true)
        XCTAssertEqual(view.adaptPassed, .content)
    }
    
    func test_displayCategories_shouldSetupCurrentStateCorrectly() {
        let genreResult: GenreResult = .fixture()
        let viewModelData: HomeUseCases.HomeView.ViewModel.Data = .init(genres: genreResult.genres)
        let viewModel: HomeUseCases.HomeView.ViewModel = .loaded(viewModelData)
        
        sut.displayCategories(viewModel: viewModel)
        
        XCTAssertEqual(view.currentState, .content)
    }
    
    func test_viewDidLoad_shoulSetupCorrectlyTableViewDelegate() {
        sut.viewDidLoad()
        XCTAssertNotNil(view.tableViewDelegate)
    }
    
    func test_viewDidLoad_shoulSetupCorrectlyTableViewDataSource() {
        sut.viewDidLoad()
        XCTAssertNotNil(view.tableViewDataSource)
    }
    
    func test_viewWillAppear_shoulCallFetchGenres() {
        sut.viewWillAppear(true)
        XCTAssertTrue(interactor.fetchGenresCalled)
    }
    
    func createMockError() -> Error {
        let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Invalid access token"])
        return error
    }

}


