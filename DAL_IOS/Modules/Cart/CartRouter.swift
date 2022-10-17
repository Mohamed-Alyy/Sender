//
//  CartRouter.swift
//  DAL_IOS
//
//  Created by rh.com.sa on 31/01/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  Router
class CartRouter: Router {
    typealias PresentingView = CartVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CartRouter: CartRouterContract {
    func addMeal() {
        for controller in view?.navigationController?.viewControllers ?? [] {
            if controller is ProviderDetailsVC {
                view?.navigationController?.popToViewController(controller, animated: true)
                return
            }
        }
        
    }
    func makeOrder(checkoutModel: CheckoutModel) {
        let scene = ShippingAddressVC.loadFromNib()
        scene.checkoutModel = checkoutModel
        view?.push(scene)
    }
    func addresses() {
        guard let scene = R.storyboard.addressesStoryboard.addressesVC() else { return }
        scene.delegate = self
        self.view?.pushPop(scene)
    }
    func home() {
        restart()
    }
    func makeOrderDone() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            guard let scene = R.storyboard.makeOrderDoneStoryboard.makeOrderDoneVC() else { return }
            scene.delegate = self
            self.view?.pushPop(scene)
        }

    }
    func mealDetails(for meal: Int?) {
        guard let scene = R.storyboard.mealDetailsStoryboard.mealDetailsVC() else { return }
        scene.mealID = meal
        scene.fromCart = true
        view?.push(scene)
    }
}

extension CartRouter: DeliveryTypeDelegate {
    func deliveryType(_ delegate: DeliveryTypeDelegate?, branch: Bool?) {
        view?.sendOrder(addressID: nil)
    }
    
    func deliveryType(_ delegate: DeliveryTypeDelegate?, delivery: Bool?) {
        addresses()
    }
}

extension CartRouter: AddressesDelegate {
    func addresses(_ delegate: AddressesDelegate?, didCreate create: Bool) {
        guard let scene = R.storyboard.createAddressStoryboard.createAddressVC() else { return }
        scene.delegate = self
        //self.view?.push(scene)
        self.view?.navigationController?.present(scene, animated: true, completion: nil)
    }
    func addresses(_ delegate: AddressesDelegate?, for address: AddressesModel.Datum?) {
        guard let scene = R.storyboard.createAddressStoryboard.createAddressVC() else { return }
        scene.delegate = self
        scene.oldAddress = address
        //self.view?.push(scene)
        self.view?.navigationController?.present(scene, animated: true, completion: nil)
    }
    func addresses(_ delegate: AddressesDelegate?, for address: Int?) {
        view?.isDeliveryHome = true
        view?.addressID = address
//        view?.setupDelivery()
    }
}

extension CartRouter: CreateAddressDelegate {
    func createAddresses(_ delegate: CreateAddressDelegate?, didCreate create: Bool) {
        addresses()
    }
}

extension CartRouter: OrderDoneDelegate {
    func orderDone(_ delegate: OrderDoneDelegate?) {
        self.home()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
            let scene = UIApplication.topViewController()
            scene?.stopLoading()
            scene?.tabBarController?.selectedIndex = 3
        }
    }
}
