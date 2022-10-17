//
//  LoginRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class LoginRouter: Router {
    typealias PresentingView = LoginVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension LoginRouter: LoginRouterContract {
    func forgetPassword() {
        guard let scene = R.storyboard.forgetPasswordStoryboard.forgetPasswordVC() else { return }
        view?.push(scene)
    }
    
    func register() {
        guard let scene = R.storyboard.registerStoryboard.registerVC() else { return }
        view?.push(scene)
    }
    
    func skip() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            guard let scene = R.storyboard.homeStoryboard.instantiateInitialViewController() else { return }
//            self.view?.push(scene)
            Router.instance.restart(storyboard: R.storyboard.homeStoryboard())
//        }
        
    }
}
