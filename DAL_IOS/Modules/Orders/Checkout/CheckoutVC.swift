//
//  CheckoutVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

// MARK: - ...  ViewController - Vars
class CheckoutVC: BaseController {
    
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var discountAmountLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    @IBOutlet weak var discountCodeTF: UITextField!
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var addressNameLb: UILabel!
    @IBOutlet weak var addressCityLb: UILabel!
    @IBOutlet weak var addressDetailsLb: UILabel!
    
    var presenter: CheckoutPresenter?
    var router: CheckoutRouter?
    var checkoutModel: CheckoutModel?
    
    @IBAction func didTappedApplyCopon(_ sender: UIButton){
        presenter?.applyCopoun()
    }
    
    @IBAction func didTappedCheckout(_ sender: UIButton){
        presenter?.createOrder()
    }
    
}

// MARK: - ...  LifeCycle
extension CheckoutVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension CheckoutVC {
    func setup() {
        subTotalLbl.text = checkoutModel?.price?.string
        taxLbl.text = checkoutModel?.tax?.string
        deliveryLbl.text = checkoutModel?.deliveryPrice?.string
        totalLbl.text = checkoutModel?.total?.string
        addressNameLb.text = checkoutModel?.addressName
        addressCityLb.text = ""
        addressDetailsLb.text = checkoutModel?.addressDes
    }
}

extension CheckoutVC: CheckoutViewContract ,PopupConfirmationViewContract{
    func applyCopoun(couponModel: CouponModel) {
        let percentage = percentageCalculator(discountAmount: couponModel.data?.discount_amount ?? 0, amount: checkoutModel?.total ?? 0)
        let checkoutTotle = checkoutModel?.total ?? 0
        let discountAmount = couponModel.data?.discount_amount ?? 0
        let discountPercent = percentage.discountAmount
        let totalValue = (checkoutTotle) - (discountAmount)
        let totalPercent = percentage.priceAfterDiscount
        let total = couponModel.data?.discount_type_key == "percent" ? totalPercent : "\(totalValue.rounded())"
        totalLbl.text = total
        discountAmountLbl.text = couponModel.data?.discount_type_key == "percent" ? discountPercent : "\(discountAmount)"
    }
    
    func percentageCalculator(discountAmount: Double, amount: Double) -> (priceAfterDiscount:String, discountAmount: String) {
        let percentage = discountAmount / 100
        let price = (percentage * amount)
        let finalPrice = amount - price
        return (finalPrice.rounded().string, price.string)
    }
    
    func didCreate() {
        NotificationCenter.default.post(name: Notification.Name("CreateOrder"), object: nil)
        router?.didCreate()
    }
    
    override func backBtn(_ sender: Any) {
        router?.dismiss()
    }
    
    func didError(error: String?) {
        openConfirmation(title: error)
    }
}
 
 

