//
//  KeychainService.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import Foundation
import KeychainAccess

protocol KeychainServiceProtocol {
    func save(key: String, data: String)
    func load(key: String) -> String?
}

class KeychainService: KeychainServiceProtocol {
    
    let keychain = Keychain()
    
    func save(key: String, data: String) {
        keychain[key] = data
    }
    
    func load(key: String) -> String? {
        return keychain[key]
    }
}
