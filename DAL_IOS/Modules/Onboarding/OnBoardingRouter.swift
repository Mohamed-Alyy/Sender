//
//  OnBoardingRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class OnBoardingRouter: Router {
    typealias PresentingView = OnBoardingVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension OnBoardingRouter: OnBoardingRouterContract {
    func startApplication() {
        self.restart(storyboard: R.storyboard.loginStoryboard())
    }
}
