//
//  ExtensionUIViewController.swift
//  My documents
//
//  Created by Kr Qqq on 29.10.2023.
//

import UIKit
import Foundation

extension UIViewController {

    func createTabButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton()
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return UIBarButtonItem(customView: button)
    }
    
    func createButton(title: String, color: UIColor, selector: Selector) -> UIButton {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
       
        return button
    }
}
