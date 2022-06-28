//
//  HomeUseCases.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 26/06/22.
//

import Foundation

enum HomeUseCases {

    enum HomeView {
        struct Request {}

        struct Response: Equatable {
            let genres: [Genre]
        }

        struct ViewModel: Equatable {
            let genres: [Genre]
        }
    }

}
