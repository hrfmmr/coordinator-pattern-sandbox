//
//  AppCoordinator.swift
//  coordinator-pattern-sandbox
//
//  Created by hrfm mr on 2021/01/24.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UITabBarController
    private var repoListCoordinator: RepoListCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = .init()
        
        let repoNavigationController = UINavigationController()
        self.repoListCoordinator = .init(navigator: repoNavigationController)
        rootViewController.viewControllers = [
            repoNavigationController
        ]
    }
    
    func start() {
        window.rootViewController = rootViewController
        repoListCoordinator.start()
        window.makeKeyAndVisible()
    }
}

final class RepoListCoordinator: Coordinator {
    private let navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        
    }
}
