//
//  ReOrderRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ReOrderRouter: Router {
    typealias PresentingView = ReOrderVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ReOrderRouter: ReOrderRouterContract {
    func reOrder() {
        view?.dismiss(animated: true, completion: {
            self.view?.delegate?.reOrder(self.view?.delegate, for: self.view?.order)
        })
    }
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
}
