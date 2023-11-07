//
//  MainCoordinator.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import UIKit

protocol MainCoordinatorProtocol {
    func startApplication() -> UIViewController
}

final class MainCoordinator: MainCoordinatorProtocol {
    
    func startApplication() -> UIViewController {
        return MainTabBarController()
    }
    
}
