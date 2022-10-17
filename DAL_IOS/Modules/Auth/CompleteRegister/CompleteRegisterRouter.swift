//
//  CompleteRegisterRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class CompleteRegisterRouter: Router {
    typealias PresentingView = CompleteRegisterVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CompleteRegisterRouter: CompleteRegisterRouterContract {
    func terms() {
        guard let scene = R.storyboard.webViewStoryboard.webViewVC() else { return }
        view?.push(scene)
    }
    func home() {
//        guard let scene = R.storyboard.homeStoryboard.instantiateInitialViewController() else { return }
//        view?.push(scene)
        Router.instance.restart(storyboard: R.storyboard.homeStoryboard())

    }
}
