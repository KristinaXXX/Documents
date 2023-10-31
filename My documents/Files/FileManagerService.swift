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
    private let settingsService = SettingsService()
    
    private var items: [String] = [] //{
    
    private let fileByteCountFormatter: ByteCountFormatter = {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        bcf.countStyle = .file
        return bcf
    }()
    
    private var contents: [ContentFile] = []// {
    
    init(pathForFolder: String) {
        self.pathForFolder = pathForFolder
        loadContents()
    }
    
    init() {
        pathForFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        loadContents()
    }
    
    func loadContents() {
        contents.removeAll()
        items = (try? FileManager.default.contentsOfDirectory(atPath: pathForFolder)) ?? []
        
        if settingsService.getSetting(typeSetting: "sorting") {
            items.sort {
                $0 < $1
            }
        } else {
            items.sort {
                $0 > $1
            }
        }
        
        for item in items {
            contents.append(ContentFile(name: item, type: isDirectory(item) ? .folder : .file, size: getFileSize(filePath: getPath(name: item))))
        }
    }
    
    func needShowFileSize() -> Bool {
        settingsService.getSetting(typeSetting: "showFileSize")
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
    
    func getFileSize(filePath: String) -> String? {
        if let attr = try? FileManager.default.attributesOfItem(atPath: filePath) {
            if let size = attr[.size] as? Int64 {
                let stringSize = fileByteCountFormatter.string(fromByteCount: size)
                return stringSize
            }
        }
        return nil
    }
    
    func getPath(at index: Int) -> String {
        pathForFolder + "/" + items[index]
    }
    
    func getPath(name: String) -> String {
        pathForFolder + "/" + name
    }
    
    func contentsOfDirectory() -> [ContentFile] {
        contents
    }
    
    func createDirectory(name: String) {
        try? FileManager.default.createDirectory(atPath: pathForFolder + "/" + name, withIntermediateDirectories: true)
        loadContents()
    }
    
    func createFile(image: UIImage) {
        if let data = image.pngData() {
            let filename = pathForFolder + "/" + (image.assetName ?? "image") + ".png"
            try? data.write(to: URL(fileURLWithPath: filename))
        }
        loadContents()
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
