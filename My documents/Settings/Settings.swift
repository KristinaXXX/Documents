//
//  Settings.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import Foundation

enum TypeSettings {
    case sorting
    case showFileSize
    case changePassword
}

struct Settings: Codable {
    //let typeSetting: TypeSettings
    let typeSetting: String
    var enabled: Bool
    let title: String
}

extension Settings {    
    static func make() -> [Settings] {
        var settingsArray: [Settings] = []
        settingsArray.append(Settings(typeSetting: "sorting", enabled: true, title: "Сортировка в алфавитном порядке"))
        settingsArray.append(Settings(typeSetting: "showFileSize", enabled: true, title: "Показывать размер файлов"))
        return settingsArray
    }
}

struct SequeSettings {
    let typeSetting: String
    let title: String
}

extension SequeSettings {
    static func make() -> [SequeSettings] {
        var sequeSettings: [SequeSettings] = []
        sequeSettings.append(SequeSettings(typeSetting: "changePassword", title: "Поменять пароль"))
        return sequeSettings
    }
}
