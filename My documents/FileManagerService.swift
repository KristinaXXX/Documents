//
//  FileManagerService.swift
//  My documents
//
//  Created by Kr Qqq on 28.10.2023.
//

import Foundation
import UIKit

protocol FileManagerServiceProtocol {
    
    //метод получения контента
    func contentsOfDirectory() -> [ContentFile]
    
    //метод добавления директории
    func createDirectory(name: String)
    
    //метод добавления файла (картинки) 
    func createFile(image: UIImage)
    
    //метод удаления контента 
    func removeContent(at index: Int)
}

class FileManagerService: FileManagerServiceProtocol {
    
    private let pathForFolder: String
    
    private var items: [String] {
        return (try? FileManager.default.contentsOfDirectory(atPath: pathForFolder)) ?? []
    }
    
    private var contents: [ContentFile] {
        var contents: [ContentFile] = []
        for item in items {
            contents.append(ContentFile(name: item, type: isDirectory(item) ? .folder : .file))
        }
        return contents
    }
    
    init(pathForFolder: String) {
        self.pathForFolder = pathForFolder
    }
    
    init() {
        pathForFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    func isDirectoryIndex(_ index: Int) -> Bool {
        let item = items[index]
        let path = pathForFolder + "/" + item
        
        var objCBool: ObjCBool = false
        
        FileManager.default.fileExists(atPath: path, isDirectory: &objCBool)
        return objCBool.boolValue
    }
    
    func isDirectory(_ item: String) -> Bool {
        let path = pathForFolder + "/" + item
        
        var objCBool: ObjCBool = false
        
        FileManager.default.fileExists(atPath: path, isDirectory: &objCBool)
        return objCBool.boolValue
    }
    
    func getPath(at index: Int) -> String {
        pathForFolder + "/" + items[index]
    }
    
    func contentsOfDirectory() -> [ContentFile] {
        contents
    }
    
    func createDirectory(name: String) {
        try? FileManager.default.createDirectory(atPath: pathForFolder + "/" + name, withIntermediateDirectories: true)
    }
    
    func createFile(image: UIImage) {
        if let data = image.pngData() {
            let filename = pathForFolder + "/" + (image.assetName ?? "image") + ".png"
            try? data.write(to: URL(fileURLWithPath: filename))
        }
    }
    
    func removeContent(at index: Int) {
        let path = pathForFolder + "/" + items[index]
        try? FileManager.default.removeItem(atPath: path)
    }
}

extension UIImage {

    var containingBundle: Bundle? {
        imageAsset?.value(forKey: "containingBundle") as? Bundle
    }

    var assetName: String? {
        imageAsset?.value(forKey: "assetName") as? String
    }

}
