//
//  DeliveryTypeVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/2/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class DeliveryTypeVC: BaseController {
    @IBOutlet weak var branchBtn: UIButton!
    @IBOutlet weak var deliveryBtn: GradientButton!
    var presenter: DeliveryTypePresenter?
    var router: DeliveryTypeRouter?
    weak var delegate: DeliveryTypeDelegate?
    var provider: Provider?
    var subTotal: Double {
        return Double(CartModel.fetch(for: CartModel.self)?.totalPrice ?? "0") ?? 0
    }
}

// MARK: - ...  LifeCycle
extension DeliveryTypeVC {
    override func viewDidLoad() {
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
extension DeliveryTypeVC {
    func setup() {
        if provider?.attributes?.deliveryOption == 0 || provider?.attributes?.minimumOrderPrice?.double() ?? 0 > subTotal {
            deliveryBtn.isHidden = true
        }
    }
    override func backBtn(_ sender: Any) {
        router?.didDismiss()
    }
    @IBAction func branch(_ sender: Any) {
        router?.branch()
    }
    @IBAction func delivery(_ sender: Any) {
        router?.delivery()
    }
}
// MARK: - ...  View Contract
extension DeliveryTypeVC: DeliveryTypeViewContract {
}
