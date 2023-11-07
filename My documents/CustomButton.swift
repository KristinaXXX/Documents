//
//  CustomButton.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import Foundation
import UIKit

final class CustomButton: UIButton {

    typealias Action = () -> Void
        
    private let buttonAction: Action
    
    init(title: String, buttonAction: @escaping Action) {
        
        self.buttonAction = buttonAction
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        backgroundColor = .lightGray
        setTitleColor(.white, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        // call closure
        buttonAction()
    }
}

