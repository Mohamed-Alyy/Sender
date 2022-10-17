//
//  CreateAddressRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class CreateAddressRouter: Router {
    typealias PresentingView = CreateAddressVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CreateAddressRouter: CreateAddressRouterContract {
    func back() {
//        view?.navigationController?.popViewController({
//            self.view?.delegate?.createAddresses(self.view?.delegate, didCreate: true)
//        })
        self.view?.delegate?.createAddresses(self.view?.delegate, didCreate: true)
        view?.navigationController?.popViewController(animated: true)
    }
    func didCreate() {
        self.view?.delegate?.createAddresses(self.view?.delegate, didCreate: true)
        view?.navigationController?.popViewController(animated: true)
//        view?.navigationController?.popViewController({
//            self.view?.delegate?.createAddresses(self.view?.delegate, didCreate: true)
//        })
    }
    
    func openMap() {
        guard let scene = R.storyboard.locationFromMapStoryboard.locationFromMapVC() else { return }
        scene.delegate = view
        self.view?.push(scene)
    }
}
