//
//  CheckoutRouter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class CheckoutRouter: Router {
    typealias PresentingView = CheckoutVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CheckoutRouter: CheckoutRouterContract {
    func dismiss() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func didCreate() {
        self.view?.navigationController?.popToRootViewController(animated: true)
    }
}
