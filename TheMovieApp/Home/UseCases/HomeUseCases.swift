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

        enum Response {
            case loading
            case loaded(Data)
            case error(Error)

            struct Data {
                let genres: [Genre]
            }
        }

        enum ViewModel {
            case loading
            case loaded(Data)
            case error(EmptyState)

            struct Data {
                let genres: [Genre]
            }
        }
    }

}
