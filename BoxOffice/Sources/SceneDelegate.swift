//
//  SceneDelegate.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let movieListViewController = MovieListViewController()
        movieListViewController.reactor = MovieListReactor()
        window.rootViewController = UINavigationController(rootViewController: movieListViewController)
        window.makeKeyAndVisible()
        self.window = window
    }
}
