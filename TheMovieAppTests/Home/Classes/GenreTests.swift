//
//  GenreTests.swift
//  TheMovieAppTests
//
//  Created by guilherme.garcia on 08/07/22.
//

@testable import TheMovieApp
import XCTest

class GenreTests: XCTestCase {
    
    var genre: Genre = .fixture()

    public func test_genre_shouldBeCorrect() {
        let actionGenre: Genre = .init(id: 01, name: "Guiherme")
        XCTAssertEqual(actionGenre, genre)
    }
    
    public func test_genre_shouldNotBeCorrect() {
        let actionGenre: Genre = .init(id: 02, name: "Guiherme")
        XCTAssertNotEqual(actionGenre, genre)
    }

}
