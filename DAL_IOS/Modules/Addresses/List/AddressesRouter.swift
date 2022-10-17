//
//  AddressesRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class AddressesRouter: Router {
    typealias PresentingView = AddressesVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension AddressesRouter: AddressesRouterContract {
    func dismiss() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func didCreate() {
        guard let scene = R.storyboard.createAddressStoryboard.createAddressVC() else { return }
//        scene.delegate = self
        //self.view?.push(scene)
        self.view?.navigationController?.pushViewController(scene)
    }
    func didEdit(for address: AddressesModel.Datum?) {
        guard let scene = R.storyboard.createAddressStoryboard.createAddressVC() else { return }
//        scene.delegate = self
        scene.oldAddress = address
        //self.view?.push(scene)
        self.view?.navigationController?.pushViewController(scene)
//        self.view?.delegate?.addresses(self.view?.delegate, for: address)
    }
    func didCompleteOrder(for address: Int?) {
        self.view?.delegate?.addresses(view?.delegate, for: address)
        view?.dismiss(animated: true, completion: nil)
    }
}
