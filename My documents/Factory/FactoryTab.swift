//
//  FactoryTab.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import UIKit

final class FactoryTab {
    enum Flow {
        case files
        case settings
    }
    
    private let flow: Flow
    let navigationController = UINavigationController()
    
    init(flow: Flow) {
        self.flow = flow
        startModule()
    }
    
    private func startModule() {
        switch flow {
            
        case .files:
            let coordinator = FilesCoordinator()
            let viewModel = FileViewModel(coordinator: coordinator)
            let viewController = FileViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(title: "Файлы", image: UIImage(systemName: "folder"), tag: 0)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Файлы"
            navigationController.setViewControllers([viewController], animated: true)
            
        case .settings:
            let coordinator = SettingsCoordinator()
            let viewModel = SettingsViewModel(coordinator: coordinator)
            let viewController = SettingsViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gearshape"), tag: 0)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Настройки"
            navigationController.setViewControllers([viewController], animated: true)
        }
    }
}
