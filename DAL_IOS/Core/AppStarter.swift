//
//  AppStarter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 10/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces

final class AppStarter {
    static let shared = AppStarter()
    private let window = (AppDelegate.shared?.window)
//    private let locationManager = LocationManager.instance
    
    private init() {}
    
    func start() {
        initLang()
        if !Localizer.isChanged {
            Localizer.set(language: Localizer.getDeviceLocale())
        } 
        setupKeyboardConfig()
        setGoogleKey()
        DispatchQueue.main.async {
            self.setRootViewController()
        }
    }
    
    
    private func setDefultLangauge(){
        if let enPath = Bundle.main.path(forResource: "en", ofType: "lproj") {
                    let enBundle = Bundle(path: enPath)
                    enBundle?.localizedString(forKey: "your_key_here", value: nil, table: nil)
        }
    }
    
    private func setupKeyboardConfig() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    fileprivate func setGoogleKey(){
        GMSServices.provideAPIKey(GoogleMapHelper.Keys.googleAPI)
        GMSPlacesClient.provideAPIKey(GoogleMapHelper.Keys.googleAPI)
    }
    
     
    
    private func setRootViewController() {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        if UserRoot.token() != nil  {
            goToOnBoarding()
        }else{
            goToOnBoarding()
        }
    }
    
    
    
    
    private func goToOnBoarding(){ 
        let rootViewController = ProviderHomeVC.loadFromNib()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func goToHomeUser(){
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        guard let rootViewController = storyboard.instantiateInitialViewController() else { return  }
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
