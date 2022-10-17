//
//  RegisterRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class RegisterRouter: Router {
    typealias PresentingView = RegisterVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension RegisterRouter: RegisterRouterContract {
    func verify(code: Int?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            guard let scene = R.storyboard.verifyCodeStoryboard.verifyCodeVC() else { return }
            scene.code = code
            scene.mobile = self.view?.mobileTxf.text
            scene.countryCode = self.view?.countryCodeLbl.text
            self.view?.push(scene)
        }
    }
}
