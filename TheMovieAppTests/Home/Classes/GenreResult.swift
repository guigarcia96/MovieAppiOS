//
//  GenresTests.swift
//  TheMovieAppTests
//
//  Created by guilherme.garcia on 08/07/22.
//

import XCTest
@testable import TheMovieApp

class GenreResultTest: XCTestCase {

    var genres: GenreResult = .fixture()

    public func test_genre_shouldBeCorrect() {
        let genresArray: GenreResult = .init(genres: [.init(id: 01, name: "Action"), .init(id: 02, name: "Comedy")])
        XCTAssertEqual(genresArray, genres)
    }

    public func test_genre_shouldNotBeCorrect() {
        let genresArray: GenreResult = .init(genres: [.init(id: 02, name: "Action"), .init(id: 03, name: "Comedy")])
        XCTAssertNotEqual(genresArray, genres)
    }

}

extension GenreResult: Equatable {
    public static func == (lhs: GenreResult, rhs: GenreResult) -> Bool {
        lhs.genres == rhs.genres
    }
}
