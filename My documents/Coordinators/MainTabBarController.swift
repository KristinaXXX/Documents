//
//  MainTabBarController.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let filesViewController: FactoryTab
    private let settingsViewController: FactoryTab
    
    
    init() {
        filesViewController = FactoryTab(flow: .files)
        settingsViewController = FactoryTab(flow: .settings)
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [
            filesViewController.navigationController,
            settingsViewController.navigationController
        ]
        selectedIndex = 0
        tabBar.backgroundColor = .white
    }
}
