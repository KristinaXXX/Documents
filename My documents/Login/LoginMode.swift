//
//  LoginMode.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import Foundation

enum LoginMode {
    case newLogin
    case repeatLogin
    case savedLogin
}

struct Password {
    var first: String
    var second: String
    
    init(first: String, second: String) {
        self.first = first
        self.second = second
    }
    
    init() {
        self.first = ""
        self.second = ""
    }
}
