//
//  CartVC.swift
//  DAL_IOS
//
//  Created by rh.com.sa on 31/01/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class CartVC: BaseController {
    @IBOutlet weak var cartTbl: UITableView!
 
//    @IBOutlet weak var cashRadioBtn: RadioButton!
//    @IBOutlet weak var madaRadioBtn: RadioButton!
//    @IBOutlet weak var hallaRadioBtn: RadioButton!
    var presenter: CartPresenter?
    var router: CartRouter?
    var providerId: Int?
    var isDeliveryHome: Bool = false
    var addressID: Int?
    var paymentMethod: PaymentMethod?
    var cartModel: CartModel?
    var tax: Double {
        return Double(cartModel?.taxAmount ?? "0") ?? 0
    }
    var delivery: Double {
        return Double(cartModel?.deliveryPrice ?? "0") ?? 0
    }
    var subTotal: Double {
        return Double(cartModel?.price ?? "0") ?? 0
    }
    var totalPrice: Double {
        return tax + subTotal  
    }
   
}

// MARK: - ...  LifeCycle
extension CartVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            cartTbl.sectionHeaderTopPadding = 20.0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
        guard let providerId = providerId else {return}
        cart?.getMyCart(providerId: providerId)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //presenter = nil
        //router = nil
    }
}
// MARK: - ...  Functions
extension CartVC {
    func setup() {
//        if provider == nil {
//            provider = CartModel.fetch(for: CartModel.self)?.data?.provider
//        }
        cartTbl.delegate = self
        cartTbl.dataSource = self
        self.cart.presenter?.view = self
    }
    func reload() {
        cartTbl.reloadData()
        if cartModel?.items?.count == 0 {
            showEmptyScreen()
        } else {
            hideEmptyScreen()
        }
    }
     
    
}
extension CartVC {
    @IBAction func addMeal(_ sender: Any) {
        router?.addMeal()
    }
    @IBAction func completeOrder(_ sender: Any) {
        guard let cartId = cartModel?.id else {return}
        let checkoutModel = CheckoutModel(cartId: cartId, tax: Double(cartModel?.taxAmount ?? "0"), price: Double(cartModel?.price ?? "0"), total: Double(cartModel?.totalPrice ?? "0"), deliveryPrice: Double(cartModel?.deliveryPrice ?? "0"))
        router?.makeOrder(checkoutModel: checkoutModel)
    }
     
}
// MARK: - ...  View Contract
extension CartVC: CartViewContract, PopupConfirmationViewContract {
    func sendOrder(addressID: Int?) {
        startLoading()
        presenter?.sendOrder(addressID: addressID, paymentMethod: paymentMethod)
    }
    func didFinishOrder() {
        stopLoading()
        router?.makeOrderDone()
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource,CartQuantityViewDelegateProtocol,AdditionsTableViewCellProtocol {
    
    func didTappedDelete(_ cartModel: CartModel.Cart) {
        guard let id = cartModel.id else {return}
        cart.delete(id: id)
    }
    
    func didTappedDeleteAdditions(_ additionsModel: AdditionsModel) {
        guard let id = additionsModel.id else {return}
        cart.delete(id: id)
    }
    
    func didTappedMinus(_ sender: UIButton) {
        let model = cartModel?.items?.getElement(at: sender.tag)
        guard let productId = model?.id else {return}
        let quantity = (model?.quantity ?? 0) - 1
        guard let providerId = providerId else {return}
        cart.cartUpdateProductQuantity(providerId: providerId, productId: productId, quantity: quantity)
    }
    
    func didTappedPlus(_ sender: UIButton) {
        let model = cartModel?.items?.getElement(at: sender.tag)
        guard let productId = model?.id else {return}
        let quantity = (model?.quantity ?? 0) + 1
        guard let providerId = providerId else {return}
        cart.cartUpdateProductQuantity(providerId: providerId, productId: productId, quantity: quantity)
    }
     
    func didTappedEdit(_ sender: UIButton) {
        let model = cartModel?.items?.getElement(at: sender.tag)
        guard let mealId = model?.product?.id else {return}
        router?.mealDetails(for: mealId)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cartModel?.items?.count ?? 0
    } 
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var cell: CartCell = CartCell.instanceFromNib()
        cell.model = cartModel?.items?.getElement(at: section)
        cell.cartDelegate = self
        cell.plusButton.tag = section
        cell.minusButton.tag = section
        cell.editButton.tag = section
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let count = cartModel?.items?.count ?? 0
        if section == (count - 1 ){
        return 260
        } else{
         return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let count = cartModel?.items?.count ?? 0
        if section == (count - 1 ){
            let cell: CartDetailsFooterCell = CartDetailsFooterCell.instanceFromNib()
            cell.subTotalLbl.text = subTotal.string
            cell.taxLbl.text = tax.string
            cell.deliveryLbl.text = delivery.string
            cell.totalLbl.text = totalPrice.string
            return cell
        }else{
            return UIView()
        }
        
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartModel?.items?.getElement(at: section)?.additions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: AdditionsTableViewCell.self, indexPath)
        cell.model = cartModel?.items?.getElement(at: indexPath.section)?.additions?.getElement(at: indexPath.row)
        cell.additionsDelegate = self
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = cartModel?.items?.getElement(at: indexPath.section)
//        router?.mealDetails(for: item?.product?.id)
//    }
}
extension CartVC: CartBuilderViewContract {
    func didFetchMyCart(cart: CartModel) {
        self.cartModel = cart
        reload()
    }
    
    func didFinishProcessOnCart() {
        reload()
    }
}
