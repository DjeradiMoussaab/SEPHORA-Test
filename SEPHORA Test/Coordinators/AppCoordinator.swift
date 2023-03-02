//
//  AppCoordinator.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import UIKit

// MARK: The App Coordinator

class AppCoordinator: BaseCoordinator {
        
    private let window: UIWindow
    var rootViewController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        rootViewController = UINavigationController()
        let productListCoordiantor = ProductListCoordinator(navigationController: rootViewController!)
        self.Add(coordinator: productListCoordiantor)
        productListCoordiantor.start()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
}
