//
//  SettingsViewModel.swift
//  My documents
//
//  Created by Kr Qqq on 30.10.2023.
//

import Foundation

class SettingsViewModel {
    
    private let coordinator: SettingsCoordinator
    private let settingsService = SettingsService()
    private var settings: [Settings]
    private let sequeSettings: [SequeSettings]
    
    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
        settings = settingsService.getSettings()
        sequeSettings = SequeSettings.make()
    }
    
    func countSettings() -> Int {
        return settings.count
    }
    
    func setting(at index: Int) -> Settings {
        return settings[index]
    }
    
    func countSequeSettings() -> Int {
        return sequeSettings.count
    }
    
    func sequeSetting(at index: Int) -> SequeSettings {
        return sequeSettings[index]
    }
    
    func sequeAction(at index: Int) {
        let seque = sequeSettings[index]
        switch seque.typeSetting {
        case "changePassword":
            coordinator.showLogin()
        default:
            return
        }
    }
    
    func updateSetting(_ setting: Settings) {
        if let i = settings.firstIndex(where: {$0.typeSetting == setting.typeSetting}) {
            settings[i].enabled = setting.enabled
        }
        settingsService.updateSettings(settings: settings)
    }

}
