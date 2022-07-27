//
//  Genre+Fixtures.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 08/07/22.
//

import Foundation

extension Genre {
    static func fixture(id: Int = 01, name: String = "Action") -> Genre {
        .init(id: id, name: name)
    }
}

extension GenreResult {
    static func fixture(genres: [Genre] = [.init(id: 01, name: "Action"), .init(id: 02, name: "Comedy")]) -> GenreResult {
        .init(genres: genres)
    }
}
