//
//  FileViewModel.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import Foundation

class FileViewModel {
    
    private let coordinator: FilesCoordinatorProtocol
    private let fileManagerService = FileManagerService()
    
    init(coordinator: FilesCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    
}
