//
//  ResetPasswordRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ResetPasswordRouter: Router {
    typealias PresentingView = ResetPasswordVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ResetPasswordRouter: ResetPasswordRouterContract {
    func login() {
        guard let scene = R.storyboard.loginStoryboard.loginVC() else { return }
        view?.push(scene)
    }
}
