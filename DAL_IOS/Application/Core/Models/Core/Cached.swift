//
//  Cached.swift
//  
//
//  Created by M.abdu on 2/3/21.
//  Copyright © 2021 com.Rowaad. All rights reserved.
//

import Foundation

protocol Cached {
    func save()
    static func isSaved()
    static func fetch<T: Codable>(for model: T.Type) -> T?
}

extension Cached where Self: Codable {
    func save() {
        guard let data = try? JSONEncoder().encode(self) else { return }
        UserDefaults.standard.setValue(nil, forKey: String(describing: type(of: self)))
        UserDefaults.standard.setValue(data, forKey: String(describing: type(of: self)))
    }
    static func isSaved() {
        
    }
    static func fetch<T: Codable>(for model: T.Type) -> T? {
        guard let data = UserDefaults.standard.data(forKey: String(describing: model)) else { return nil }
        let object = try? JSONDecoder().decode(model, from: data)
        return object
    }
}
