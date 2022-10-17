//
//  SetNewPasswordRouter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 02/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

class SetNewPasswordRouter: Router {
    typealias PresentingView = SetNewPasswordVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SetNewPasswordRouter: SetNewPasswordRouterContract {
    func login() {
        UserRoot.logout()
        Router.instance.restart()
    }
}
