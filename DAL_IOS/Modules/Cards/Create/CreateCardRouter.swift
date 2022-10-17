//
//  CreateCardRouter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class CreateCardRouter: Router {
    typealias PresentingView = CreateCardVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CreateCardRouter: CreateCardRouterContract {
    func back() { 
        self.view?.delegate?.createCard(self.view?.delegate, didCreate: true)
        view?.navigationController?.popViewController(animated: true)
    }
    func didCreate() {
        self.view?.delegate?.createCard(self.view?.delegate, didCreate: true)
        view?.navigationController?.popViewController(animated: true)
    }
     
}
