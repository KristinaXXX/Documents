//
//  LoginCoordinator.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import UIKit

protocol LoginCoordinatorProtocol {
    func showFailLogin(text: String)
    func showFiles()
}

final class LoginCoordinator: LoginCoordinatorProtocol {

    var navigationController: UINavigationController?

    func showFailLogin(text: String) {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showFiles() {
        let mainCoordinator = MainCoordinator()
        let startViewController = mainCoordinator.startApplication()
        startViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(startViewController, animated: true)
    }
}
