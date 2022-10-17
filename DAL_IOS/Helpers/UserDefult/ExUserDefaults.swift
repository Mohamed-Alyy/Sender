//
//  ExUserDefaults.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 10/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
typealias UD = UserDefaults

var prefs: UserDefaults {
    return UserDefaults.standard
}

extension UserDefaults {
    
    enum PrefKeys {
        static let appLang = "appLang"
        static let userType = "userType"
        static let userTypeIsProvider = "userTypeIsProvider"
    }
    
    func set<T>(encodable object: T?, forKey key: String) where T: Encodable {
        guard let object = object else {
            prefs.set(nil, forKey: key)
            return
        }
        if let encoded = try? JSONEncoder().encode(object) {
            prefs.set(encoded, forKey: key)
        }
    }
    
    func decodable<T>(forKey key: String, of type: T.Type) -> T? where T: Decodable {
        guard let jsonData = prefs.data(forKey: key),
            let object = try? JSONDecoder().decode(type, from: jsonData) else {
                return nil
        }
        return object
    }
}
