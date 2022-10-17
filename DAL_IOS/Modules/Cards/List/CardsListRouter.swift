//
//  CardsListRouter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class CardsListRouter: Router {
    typealias PresentingView = CardsListVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CardsListRouter: CardsListRouterContract {
    func dismiss() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func didCreate() {
        let scene = CreateCardVC.loadFromNib()
//        scene.delegate = self
        //self.view?.push(scene)
        self.view?.navigationController?.pushViewController(scene)
    }
    func didEdit(for oldCard: CardsListModel.Datum?) {
        let scene = CreateCardVC.loadFromNib()
//        scene.delegate = self
        scene.oldCard = oldCard
        //self.view?.push(scene)
        self.view?.navigationController?.pushViewController(scene)
//        self.view?.delegate?.addresses(self.view?.delegate, for: address)
    }
    func didCompleteOrder(for address: Int?) {
        self.view?.delegate?.addresses(view?.delegate, for: address)
        view?.dismiss(animated: true, completion: nil)
    }
}
