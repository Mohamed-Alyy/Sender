//
//  NewSearchContainerModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class Keyword: Codable {
    var history: [String]?
}

class SearchHistory: NSObject {
    static let key: String = "SEARCH_HISTORY"
    
    private func fetchHistory() -> Keyword? {
        if let model = UserDefaults.standard.data(forKey: SearchHistory.key) {
            let history = try? JSONDecoder().decode(Keyword.self, from: model)
            if history == nil {
                let keyword = Keyword.init()
                keyword.history = []
                return keyword
            } else {
                return history
            }
        }
        let keyword = Keyword.init()
        keyword.history = []
        return keyword
    }
    func fetch() -> [String] {
        return fetchHistory()?.history ?? []
    }
    func save(text: String?) {
        guard let text = text else { return }
        let history = fetchHistory()
        history?.history?.append(text)
        let data = try? JSONEncoder().encode(history)
        guard let json = data else { return }
        UserDefaults.standard.setValue(json, forKey: SearchHistory.key)
    }
    func delete(text: String?) {
        guard let text = text else { return }
        let history = fetchHistory()
        history?.history = history?.history?.removeAll(text)
        let data = try? JSONEncoder().encode(history)
        guard let json = data else { return }
        UserDefaults.standard.setValue(json, forKey: SearchHistory.key)
    }
    func delete() {
        let history = fetchHistory()
        history?.history?.removeAll()
        let data = try? JSONEncoder().encode(history)
        guard let json = data else { return }
        UserDefaults.standard.setValue(json, forKey: SearchHistory.key)
    }
}
