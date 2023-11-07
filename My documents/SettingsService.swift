//
//  SettingsService.swift
//  My documents
//
//  Created by Kr Qqq on 31.10.2023.
//

import Foundation

final class SettingsService {
   
    private let key = "settings"
    private let userDefaultsStorage = UserDefaultsStorage()
    
    func updateSettings(settings: [Settings]) {
        userDefaultsStorage.save(key: key, items: settings)
    }
    
    func getSettings() -> [Settings] {
        if let storageSettings = userDefaultsStorage.load(key: key) {
            storageSettings
        } else {
            Settings.make()
        }
    }
    
    func getSetting(typeSetting: String) -> Bool {
        let settings = getSettings()
        if let i = settings.firstIndex(where: {$0.typeSetting == typeSetting}) {
            return settings[i].enabled
        } else {
            return false
        }
    }
}
