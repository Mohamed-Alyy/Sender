//
//  CartBuilder.swift
//  DAL_IOS
//
//  Created by rh.com.sa on 31/01/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Cart Builder to manage cart items
class CartBuilder: NSObject, CartBuilderViewContract {
    
    // MARK: - ...  Items List
    private var items: [CartModel.Cart] {
        return list()
    }
    // MARK: - ... User defaults
    private var defaults: UserDefaults?
    
    // MARK: - ... Presenter
    var presenter: CartBuilderPresenter?
    // MARK: - ...  initialize
    override init() {
        super.init()
        defaults = UserDefaults.standard
        presenter = .init()
        //presenter?.view = self
    }
    
//    // MARK: - ...  Store items in KEY
//    private func store(items: [T]) {
//        guard let data = try? JSONEncoder().encode(items) else { return }
//        defaults?.setValue(data, forKey: CARTKEY)
//    }
    private func getIndex(for item: Cart) -> Int? {
        for index in 0..<items.count {
            if item.id == items[index].id {
                return index
            }
        }
        return nil
    }
    // MARK: - ...  List of items
    func fetch() -> CartModel? {
        let model = CartModel.fetch(for: CartModel.self)
        return model
    }
    
    // MARK: - ...  List of items
    func list() -> [CartModel.Cart] {
        let model = CartModel.fetch(for: CartModel.self)?.items ?? []
        return model
    }
    
    // MARK: - ...  Insert Item
    func insert(item: Cart?, note: String? = nil, fromCart: Bool = false) {
        guard let item = item else { return }
        presenter?.insert(item: item, note: note, fromCart: fromCart)
    }
    
    func insertToCart(isEdit: Bool,productId: Int, quantity: Int,selectedExtras: [AdditionsModel]? = nil) {
        switch isEdit {
        case true:
            editCart(productId: productId, quantity: quantity,selectedExtras: selectedExtras)
        case false:
            addToCart(productId: productId, quantity: quantity,selectedExtras: selectedExtras)
        }
    }
    
    private func addToCart(productId: Int, quantity: Int,selectedExtras: [AdditionsModel]? = nil) {
        presenter?.insertToCart(productId: productId, quantity: quantity, selectedExtras: selectedExtras)
    }
    
   private func editCart(productId: Int, quantity: Int,selectedExtras: [AdditionsModel]? = nil){
        presenter?.editCart(productId: productId, quantity: quantity, selectedExtras: selectedExtras)
    }
    
    func cartUpdateProductQuantity(providerId: Int,productId: Int,quantity: Int){
        presenter?.cartUpdateProductQuantity(providerId: providerId, productId: productId, quantity: quantity)
    }
    
    func getMyCart(providerId: Int) {
        presenter?.getMyCart(providerId: providerId)
    }
    // MARK: - ...  Delete Item
    func delete(item: Cart?) {
        guard let item = item else { return }
        let index = self.item(for: item)
        presenter?.delete(cartID: index?.id)
    }
    // MARK: - ...  Delete Item
    func delete(item: CartModel.Cart?) {
        guard let item = item else { return }
        presenter?.delete(cartID: item.id)
    }
    func item(for index: Int?) -> CartModel.Cart? {
        guard let index = index else { return nil }
        return items[index]
    }
    func item(for item: Cart?) -> CartModel.Cart? {
        guard let item = item else { return nil }
        guard let index = getIndex(for: item) else { return nil }
        return items[index]
    }
    func count() -> Int {
        return items.count
    }
    func totalPrice() -> Double {
        var price: Double = 0.0
        for index in 0..<items.count {
            if let localItem = items[index] as? Cart {
                price += localItem.priceForItem()
            }
        }
        return price
    }
    
    func delete(id: Int) {
        presenter?.delete(cartID: id)
    }
//    static func destroy() {
//        CartModel().save()
//    }
//    func destroy() {
//        CartModel().save()
//    }
    func didFinishProcessOnCart() {
        
    }
    
    func didFetchMyCart(cart: CartModel) {
         
    }
}
