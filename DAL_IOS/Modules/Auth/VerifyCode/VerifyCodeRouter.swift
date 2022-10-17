//
//  VerifyCodeRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class VerifyCodeRouter: Router {
    typealias PresentingView = VerifyCodeVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension VerifyCodeRouter: VerifyCodeRouterContract {
    func resetPassword(secret_code: String) {
        guard let scene = R.storyboard.resetPasswordStoryboard.resetPasswordVC() else { return }
        scene.mobile = view?.mobile
        scene.countryCode = view?.countryCode
        scene.secret_code = secret_code
        scene.userId = view?.userId
        view?.push(scene)
    }
    func completeRegister() {
        guard let scene = R.storyboard.completeRegisterStoryboard.completeRegisterVC() else { return }
        scene.mobile = view?.mobile
        scene.countryCode = view?.countryCode
        view?.push(scene)
    }
}
