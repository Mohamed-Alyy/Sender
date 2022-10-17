//
//  LanguageRouter.swift
//  DAL_IOS
//
//  Created by Mabdu on 17/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class LanguageRouter: Router, LanguageRouterContract {
    typealias PresentingView = LanguageVC
    weak var view: LanguageVC?
    deinit {
        self.view = nil
    }
}
