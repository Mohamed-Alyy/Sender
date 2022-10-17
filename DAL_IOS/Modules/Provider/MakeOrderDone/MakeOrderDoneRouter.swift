//
//  MakeOrderDoneRouter.swift
//  DAL_IOS
//
//  Created by Mabdu on 24/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class MakeOrderDoneRouter: Router {
    typealias PresentingView = MakeOrderDoneVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MakeOrderDoneRouter: MakeOrderDoneRouterContract {
    func didDone(go orders: Bool? = nil) {
        view?.dismiss(animated: true, completion: {
            if orders != nil {
                self.view?.delegate?.orderDone(self.view?.delegate)
            }
        })
    }
}
