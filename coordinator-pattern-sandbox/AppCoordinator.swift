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
    private var itemListCoordinator: ItemListCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = .init()
        
        let repoNavigationController = UINavigationController()
        self.itemListCoordinator = .init(navigator: repoNavigationController)
        rootViewController.viewControllers = [
            repoNavigationController
        ]
    }
    
    func start() {
        window.rootViewController = rootViewController
        itemListCoordinator.start()
        window.makeKeyAndVisible()
    }
}

final class ItemListCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var itemListViewController: ItemListViewController?
    private var itemDetailCoordinator: ItemDetailCoordinator?

    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let viewController = ItemListViewController()
        viewController.delegate = self
        navigator.pushViewController(viewController, animated: true)
        self.itemListViewController = viewController
    }
}

extension ItemListCoordinator: ItemListViewControllerDelefgate {
    func itemListViewController(_ viewController: ItemListViewController, didSelect item: Item) {
        let coordinator = ItemDetailCoordinator(navigator: navigator, item: item)
        coordinator.start()
        self.itemDetailCoordinator = coordinator
    }
}

final class ItemDetailCoordinator: Coordinator {
    private let navigator: UINavigationController
    private let item: Item
    private var itemDetailViewController: ItemDetailViewController?
    
    init(navigator: UINavigationController, item: Item) {
        self.navigator = navigator
        self.item = item
    }
    
    func start() {
        let viewController = ItemDetailViewController(item: item)
        navigator.pushViewController(viewController, animated: true)
        self.itemDetailViewController = viewController
    }
}
