//
//  HomeWorkerTests.swift
//  TheMovieAppTests
//
//  Created by guilherme.garcia on 19/07/22.
//

import XCTest
@testable import TheMovieApp

class HomeWorkerTests: XCTestCase {

    let repositorySpy = GenresRepositorySpy()
    private lazy var  sut = HomeWorker(repository: repositorySpy)

    func test_loadGenres_shouldReturnSuccess() {
        let genreResult: GenreResult = .fixture()
        repositorySpy.contentToBeReturned = .success(genreResult.genres)

        sut.loadGenres { result in
            switch result {
            case .success(let genres):
                XCTAssertEqual(genreResult.genres, genres)
            case .failure(let error):
                XCTFail("Unexpected error type request \(error)")
            }

        }
    }

    func test_loadGenres_shouldReturnError() {
        repositorySpy.contentToBeReturned = .failure(createMockError())

        sut.loadGenres { result in
            switch result {
            case .success:
                XCTFail("Should return error")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }

    func createMockError() -> Error {
        let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Invalid access token"])
        return error
    }
}
