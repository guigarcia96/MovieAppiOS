//
//  Genres.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 26/06/22.
//

import Foundation

// MARK: - Genre
public struct Genre: Codable {
    let id: Int
    let name: String
}

extension Genre: Equatable {
    public static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - GenreResult
public struct GenreResult: Codable {
    let genres: [Genre]
}
