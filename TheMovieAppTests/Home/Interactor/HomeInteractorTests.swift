//
//  HomeInteractorTests.swift
//  TheMovieAppTests
//
//  Created by guilherme.garcia on 15/07/22.
//

import XCTest
@testable import TheMovieApp

class HomeInteractorTests: XCTestCase {

    private let presenterSpy = HomePresenterSpy()
    private let worker = HomeWorkerSpy()
    private lazy var sut = HomeInteractor(presenter: presenterSpy, worker: worker)

    func test_fetchGenres_shouldSetupCorrectlyWhenValueShouldBeLoaded() {
        let genreResult: GenreResult = .fixture()
        worker.contentToBeReturned = .success(genreResult.genres)
        let expectedResult: HomeUseCases.HomeView.Response = .loaded(.init(genres: genreResult.genres))
        sut.fetchGenres(request: .init())

        XCTAssertTrue(worker.loadGenresCalled)
        XCTAssertNotNil(worker.contentToBeReturned)
        XCTAssertEqual(expectedResult, presenterSpy.presentGenresPassed)
        XCTAssertTrue(presenterSpy.presentGenresCalled)
    }

    func test_fetchGenres_shouldSetupCorrectlyWhenValueShouldBeLoading() {
        sut.fetchGenres(request: .init())

        XCTAssertEqual(.loading, presenterSpy.presentGenresPassed)
        XCTAssertTrue(presenterSpy.presentGenresCalled)
    }

    func test_fetchGenres_shouldSetupCorrectlyWhenValueShouldBeError() {
        worker.contentToBeReturned = .failure(createMockError())
        let expectedResult: HomeUseCases.HomeView.Response = .error(createMockError())
        sut.fetchGenres(request: .init())

        XCTAssertTrue(worker.loadGenresCalled)
        XCTAssertNotNil(worker.contentToBeReturned)
        XCTAssertEqual(expectedResult, presenterSpy.presentGenresPassed)
        XCTAssertTrue(presenterSpy.presentGenresCalled)
    }

    func test_fetchGenres_shouldNotBeCorrectly() {
        let genreResult: GenreResult = .fixture()
        worker.contentToBeReturned = .failure(createMockError())
        let expectedResult: HomeUseCases.HomeView.Response = .loaded(.init(genres: genreResult.genres))
        sut.fetchGenres(request: .init())

        XCTAssertNotEqual(expectedResult, presenterSpy.presentGenresPassed)
    }

    func test_fetchGenres_shouldBatata() {
        let genreResult: GenreResult = .fixture()
        worker.contentToBeReturned = .success(genreResult.genres)
        let expectedResult: HomeUseCases.HomeView.Response = .loaded(.init(genres: genreResult.genres))
        sut.fetchGenres(request: .init())

        XCTAssertTrue(worker.loadGenresCalled)
        XCTAssertNotNil(worker.contentToBeReturned)
        XCTAssertEqual(expectedResult, presenterSpy.presentGenresPassed)
        XCTAssertTrue(presenterSpy.presentGenresCalled)
    }

    func createMockError() -> Error {
        let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Invalid access token"])
        return error
    }

}

extension HomeUseCases.HomeView.Response: Equatable {
    public static func == (lhs: HomeUseCases.HomeView.Response, rhs: HomeUseCases.HomeView.Response) -> Bool {
        switch (lhs, rhs) {
        case (.loaded(let lhsData), .loaded(let rhsData)):
            return lhsData.genres == rhsData.genres
        case (.loading, .loading):
            return true
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
