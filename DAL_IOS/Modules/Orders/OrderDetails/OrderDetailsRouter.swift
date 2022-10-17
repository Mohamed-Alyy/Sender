//
//  OrderDetailsRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class OrderDetailsRouter: Router {
    typealias PresentingView = OrderDetailsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension OrderDetailsRouter: OrderDetailsRouterContract {
    func dismiss() {
        if view?.forceRate == true {
            view?.openConfirmation(title: "Please rate first before closing".localized)
            return
        }
        view?.delegate?.orderDetails(view?.delegate)
        view?.dismiss(animated: false, completion: nil)
    }
    func didEdited() {
        view?.delegate?.orderDetails(view?.delegate)
        view?.dismiss(animated: false, completion: {
            self.view?.delegate?.orderDetails(self.view?.delegate, forEdit: true)
        })
    }
}
