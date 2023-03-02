//
//  ProductListCoordinator.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import UIKit

// MARK: The Product List Coordinator

class ProductListCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        
        let viewController = ProductListViewController()
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
}
