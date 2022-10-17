//
//  ShippingAddressRouter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ShippingAddressRouter: Router {
    typealias PresentingView = ShippingAddressVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ShippingAddressRouter: ShippingAddressRouterContract {
    func dismiss() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func didCreate() {
        guard let scene = R.storyboard.createAddressStoryboard.createAddressVC() else { return }
        self.view?.navigationController?.pushViewController(scene)
    } 
    func didCompleteOrder(checkoutModel: CheckoutModel) {
        let scene = CheckoutVC.loadFromNib()
        scene.checkoutModel = checkoutModel
        self.view?.navigationController?.pushViewController(scene)
    }
}
