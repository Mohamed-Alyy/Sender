//
//  PopupConfirmationRouter.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/4/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class PopupConfirmationRouter: Router, PopupConfirmationRouterContract {
    typealias PresentingView = PopupConfirmationVC
    weak var view: PopupConfirmationVC?
    deinit {
        self.view = nil
    }
}
