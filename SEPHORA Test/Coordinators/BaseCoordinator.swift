//
//  BaseCoordinator.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 2/3/2023.
//

import Foundation

// MARK: The Coordinator Protocol

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    
    func Add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func Remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0 !== coordinator })
    }
    
}

// MARK: The Base Implementation of Coordinator Protocol
/// to avoid initializing proprties in every coordinator.

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("children should implement 'start'.")
    }
    
}

