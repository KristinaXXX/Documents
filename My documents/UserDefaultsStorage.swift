//
//  UserDefaultsStorage.swift
//  My documents
//
//  Created by Kr Qqq on 31.10.2023.
//

import Foundation

final class UserDefaultsStorage {
    func save(key: String, items: [Settings]) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(items) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func load(key: String) -> [Settings]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let items = try? decoder.decode([Settings].self, from: data) else {
            assertionFailure("Decode error")
            return nil
        }
        return items
    }
}
