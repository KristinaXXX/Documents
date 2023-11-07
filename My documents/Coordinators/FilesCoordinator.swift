//
//  FilesCoordinator.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import UIKit

protocol FilesCoordinatorProtocol {
    func showFailLogin(text: String)
    func showFiles()
}

final class FilesCoordinator: FilesCoordinatorProtocol {

    var navigationController: UINavigationController?

    func showFailLogin(text: String) {
        let alert = UIAlertController(title: "Fail", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showFiles() {

    }
}
