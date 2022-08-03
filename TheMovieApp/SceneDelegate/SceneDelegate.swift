//
//  SceneDelegate.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 24/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let presenter = HomePresenter()
        let genresRepository = GenresRepository()
        let worker = HomeWorker(repository: genresRepository)
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        let viewController = HomeViewController(interactor: interactor)
        presenter.view = viewController
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = HomeViewController(interactor: interactor)
        self.window = window
        window.makeKeyAndVisible()
    }
}
