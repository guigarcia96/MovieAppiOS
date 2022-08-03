//
//  AppDelegate.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 24/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let presenter = HomePresenter()
        let genresRepository = GenresRepository()
        let worker = HomeWorker(repository: genresRepository)
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        let viewController = HomeViewController(interactor: interactor)
        presenter.view = viewController
        window = UIWindow()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }

}
