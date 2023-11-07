//
//  LoginViewModel.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import Foundation

class LoginViewModel {
    
    private let coordinator: LoginCoordinatorProtocol
    private let keychainService = KeychainService()
    private let key = "password"
    
    init(coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func login(passwordStruct: Password, loginMode: LoginMode, completion: @escaping (LoginMode) -> Void) {
        switch loginMode {
        case .repeatLogin:
            guard passwordStruct.first == passwordStruct.second else {
                coordinator.showFailLogin(text: "Пароли не совпадают")
                completion(.newLogin)
                return
            }

            keychainService.save(key: key, data: passwordStruct.first)
        case .savedLogin:
            guard keychainService.load(key: key) == passwordStruct.first else {
                coordinator.showFailLogin(text: "Пароль не совпадает с сохраненным")
                return
            }
            
        default:
            return
        }
        coordinator.showFiles()
    }
    
    func haveSavedPassword() -> Bool {
        guard keychainService.load(key: key) != nil else { return false }
        return true
    }  
}
