//
//  ReOrderVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ReOrderVC: BaseController {
    var presenter: ReOrderPresenter?
    var router: ReOrderRouter?
    weak var delegate: ReOrderDelegate?
    var order: OrdersModel.Datum?
}

// MARK: - ...  LifeCycle
extension ReOrderVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ReOrderVC {
    func setup() {
    }
}
extension ReOrderVC {
    override func backBtn(_ sender: Any) {
        router?.dismiss()
    }
    @IBAction func reOrder(_ sender: Any) {
        router?.reOrder()
    }
}
// MARK: - ...  View Contract
extension ReOrderVC: ReOrderViewContract {
}
