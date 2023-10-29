//
//  ContentFile.swift
//  My documents
//
//  Created by Kr Qqq on 29.10.2023.
//

import Foundation

enum FileType {
    case folder
    case file
}

struct ContentFile {
    let name: String
    let type: FileType
}
