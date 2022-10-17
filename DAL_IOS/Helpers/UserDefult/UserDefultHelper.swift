//
//  UserDefultHelper.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 10/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

public class UserDefultHelper {
    
    /// Singletone instance
    public static let instance: UserDefultHelper = UserDefultHelper()
    
    // singletone
    private init(){}
     
    
    var appLang: String {
        get { return prefs.string(forKey: UD.PrefKeys.appLang) ?? Locale.current.languageCode ?? "en" }
        set { prefs.set(newValue, forKey: UD.PrefKeys.appLang) }
    }
    
    var userTypeIsProvider: Bool {
        get { return prefs.bool(forKey: UD.PrefKeys.userTypeIsProvider) }
        set { prefs.set(newValue, forKey: UD.PrefKeys.userTypeIsProvider) }
    }
    
    var userType: String {
        get { return prefs.string(forKey: UD.PrefKeys.userType) ?? "" }
        set { prefs.set(newValue, forKey: UD.PrefKeys.userType) }
    }
     
    
}


