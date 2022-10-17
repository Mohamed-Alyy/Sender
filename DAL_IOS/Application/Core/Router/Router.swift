//
//  Router.swift
//  BaseIOS
//
//  Created by M.abdu on 10/12/20.
//  Copyright © 2020 com.M.abdu. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  Router for All Application
class Router: NSObject {
    struct Static {
        static var instance: Router?
    }
    class var instance: Router {
        if Static.instance == nil {
            Static.instance = Router()
        }
        return Static.instance!
    }
    let storyboard = UIStoryboard(name: "LangIntroStoryboard", bundle: nil)
    // MARK: - ...  Restart the main storyboard
    func restart(storyboard: UIStoryboard = Router.instance.storyboard) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if UserRoot.token() != nil {
                guard let scene = R.storyboard.homeStoryboard().instantiateInitialViewController() else { return }
                let delegate = UIApplication.shared.delegate as? AppDelegate
                delegate?.window?.rootViewController = scene
            } else {
                if UserDefaults.standard.bool(forKey: "LANG_INTRO") == true {
                    if storyboard == Router.instance.storyboard {
                        let scene = R.storyboard.loginStoryboard().instantiateInitialViewController()
                        let delegate = UIApplication.shared.delegate as? AppDelegate
                        delegate?.window?.rootViewController = scene
                    } else {
                        guard let scene = storyboard.instantiateInitialViewController() else { return }
                        let delegate = UIApplication.shared.delegate as? AppDelegate
                        delegate?.window?.rootViewController = scene
                    }
                } else {
                    let scene = storyboard.instantiateInitialViewController()
                    let delegate = UIApplication.shared.delegate as? AppDelegate
                    delegate?.window?.rootViewController = scene
                }
            }
        }
    }
    
    func rootViewController(){
        
    }
    
    func rateLastOrder() {
        
    }
    // MARK: - ...  Restart the auth storyboard
    func unAuthorized(storyboard: UIStoryboard = R.storyboard.loginStoryboard()) {
        let scene = storyboard.instantiateInitialViewController()
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window?.rootViewController = scene
    }
}
