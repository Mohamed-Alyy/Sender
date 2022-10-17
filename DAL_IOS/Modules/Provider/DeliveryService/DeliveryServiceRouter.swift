//
//  DeliveryServiceRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class DeliveryServiceRouter: Router {
    typealias PresentingView = DeliveryServiceVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension DeliveryServiceRouter: DeliveryServiceRouterContract {
    func confirm(ok: Bool? = nil) {
        if ok != nil {
            view?.delegate?.deliveryService(view?.delegate, for: view?.provider)
        }
        view?.dismiss(animated: true, completion: nil)
    }
}
