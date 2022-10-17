//
//  CartBuilderPresenter.swift
//  DAL_IOS
//
//  Created by Mabdu on 16/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  Presenter
class CartBuilderPresenter: BasePresenter<CartBuilderViewContract> {
    // MARK: - ...  List of items
    func fetch(for provider: Int? = nil) {
        if UserRoot.token() == nil {
            return
        }
        if provider != nil {
            NetworkManager.instance.paramaters["provider_id"] = provider
        }
        NetworkManager.instance.request(.cart, type: .get, CartModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    model?.save()
                case .failure:
                    break
            }
        }
    }
    
    func getMyCart(providerId: Int){
        var view = UIViewController()
        if let viewController = self.view as? CartVC {
            view = viewController
        } else if let viewController = self.view as? ProviderDetailsVC  {
            view = viewController
        }
        view.startLoading()
        NetworkManager.instance.paramaters["provider_id"] = providerId
        NetworkManager.instance.request(.myCart, type: .get, CartResponse.self) { [weak self] (response) in
            defer {view.stopLoading()}
            switch response {
                case .success(let model):
                guard let model = model?.data else {return}
                model.save()
                self?.view?.didFetchMyCart(cart: model)
                case .failure:
                    break
            }
        }
    }
    
    
    func cartUpdateProductQuantity(providerId: Int,productId: Int,quantity: Int){
        NetworkManager.instance.paramaters["quantity"] = quantity
        let method = NetworkConfigration.EndPoint.endPoint(point: .myCart, paramters: [productId,"update"])
        NetworkManager.instance.request(method, type: .post, CartModel.self) { [weak self] (response) in
            switch response {
                case .success(_):
                self?.getMyCart(providerId: providerId)
                case .failure:
                    break
            }
        }
    }
    
    func insertToCart(addition: Bool = false,productId: Int, quantity: Int,selectedExtras: [AdditionsModel]? = nil){
        guard let view = self.view as? MealDetailsVC else {return}
        view.startLoading()
        var indexLoop = 0
        NetworkManager.instance.paramaters["item_type"] = addition ? "product_addition" : "product"
        NetworkManager.instance.paramaters["product_id"] = productId
        
        if addition == false {
            NetworkManager.instance.paramaters["quantity"] = quantity
        }else{
           
            for i in selectedExtras ?? [] {
                NetworkManager.instance.paramaters["product_additions[\(indexLoop)][id]"] = i.id
                NetworkManager.instance.paramaters["product_additions[\(indexLoop)][quantity]"] = i.quantity
                indexLoop += 1
            }
        }
       
        
        NetworkManager.instance.request(.addToCart, type: .post, CartResponse.self) { [weak self] (response) in
            defer{view.stopLoading()}
            switch response {
                case .success(let model):
                guard let model = model?.data else {return}
                let extraCount = selectedExtras?.count ?? 0
                print("indexLoop", indexLoop)
                print("extraCount", extraCount)
                if indexLoop != extraCount {
                    self?.insertToCart(addition: true, productId: productId, quantity: quantity, selectedExtras: selectedExtras)
                   return
                }
                model.save()
                self?.view?.didFinishProcessOnCart()
                case .failure:
                    break
            }
        }
    }
    
    
    func editCart(productId: Int, quantity: Int,selectedExtras: [AdditionsModel]? = nil){
        let viewController = self.view as? CartVC
        viewController?.startLoading()
        var indexLoop = 0
        NetworkManager.instance.paramaters["product_id"] = productId
        NetworkManager.instance.paramaters["quantity"] = quantity
        NetworkManager.instance.paramaters["item_type"] = "product"
        for i in selectedExtras ?? [] {
            NetworkManager.instance.paramaters["product_additions[\(indexLoop)][id]"] = i.id
            NetworkManager.instance.paramaters["product_additions[\(indexLoop)][quantity]"] = i.quantity
            indexLoop += 1
        }
        NetworkManager.instance.request(.editCart, type: .post, CartResponse.self) { [weak self] (response) in
            defer{viewController?.stopLoading()}
            switch response {
                case .success(let model):
                guard let model = model?.data else {return}
                model.save()
                self?.view?.didFinishProcessOnCart()
                case .failure:
                    break
            }
        }
    }
    
    
    // MARK: - ...  List of items
    func insert(item: Cart?, note: String?, fromCart: Bool = false) {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        NetworkManager.instance.paramaters["product_id"] = item?.id
        NetworkManager.instance.paramaters["qty"] = item?.quantity
        NetworkManager.instance.paramaters["extra_id"] = item?.extrasIDS().toJson()
        NetworkManager.instance.paramaters["extra_qty"] = item?.extrasQTY().toJson()
        NetworkManager.instance.paramaters["delivery_type"] = "indoor"
        NetworkManager.instance.paramaters["payment_method"] = "cash"
        NetworkManager.instance.paramaters["notes"] = note
        NetworkManager.instance.paramaters["isEdit"] = fromCart
        NetworkManager.instance.request(.cart, type: .post, CartModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    model?.save()
                    self?.view?.didFinishProcessOnCart()
                case .failure:
                    break
            }
        }
    }
    // MARK: - ...  List of items
    func delete(cartID: Int?) {
        let viewController = self.view as? CartVC
        viewController?.startLoading()
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        let method = NetworkConfigration.EndPoint.endPoint(point: .myCart, paramters: [cartID ?? 0,"delete"])
        NetworkManager.instance.request(method, type: .delete, CartResponse.self) { [weak self] (response) in
            defer { viewController?.stopLoading() }
            switch response {
                case .success(let model):
                guard let model = model?.data else {return}
                    model.save()
                self?.view?.didFetchMyCart(cart: model)
                case .failure:
                    break
            }
        }
    }
    
}
