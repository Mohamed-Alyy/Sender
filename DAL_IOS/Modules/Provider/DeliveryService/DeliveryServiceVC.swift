//
//  DeliveryServiceVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class DeliveryServiceVC: BaseController {
    @IBOutlet weak var deliveryServiceLbl: UILabel!
    @IBOutlet weak var freeDeliveryLbl: UILabel!
    
    var presenter: DeliveryServicePresenter?
    var router: DeliveryServiceRouter?
    weak var delegate: DeliveryServiceDelegate?
    var provider: Provider?
}

// MARK: - ...  LifeCycle
extension DeliveryServiceVC {
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
extension DeliveryServiceVC {
    func setup() {
        deliveryServiceLbl.text = "\("To enjoy the delivery service, you must order products with a value of".localized) \(provider?.attributes?.minimumOrderPrice ?? "") \("riyals".localized)"
        freeDeliveryLbl.text = "\("For free delivery, products with a value of more than".localized) \(provider?.attributes?.freeOrderPrice ?? "") \("riyals must be requested".localized)"
    }
    override func backBtn(_ sender: Any) {
        router?.confirm()
    }
    @IBAction func done(_ sender: Any) {
        router?.confirm(ok: true)
    }
}
// MARK: - ...  View Contract
extension DeliveryServiceVC: DeliveryServiceViewContract {
}
