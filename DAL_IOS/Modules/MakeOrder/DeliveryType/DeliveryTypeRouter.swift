//
//  DeliveryTypeRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/2/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class DeliveryTypeRouter: Router {
    typealias PresentingView = DeliveryTypeVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension DeliveryTypeRouter: DeliveryTypeRouterContract {
    func didDismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
    func branch() {
        view?.dismiss(animated: true, completion: {
            self.view?.delegate?.deliveryType(self.view?.delegate, branch: true)
        })
    }
    func delivery() {
        view?.dismiss(animated: true, completion: {
            self.view?.delegate?.deliveryType(self.view?.delegate, delivery: true)
        })
    }
}
