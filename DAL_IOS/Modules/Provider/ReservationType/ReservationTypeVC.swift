//
//  ReservationTypeVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ReservationTypeVC: BaseController {
    var presenter: ReservationTypePresenter?
    var router: ReservationTypeRouter?
    weak var delegate: ReservationTypeDelegate?
}

// MARK: - ...  LifeCycle
extension ReservationTypeVC {
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
extension ReservationTypeVC {
    func setup() {
    }
    override func backBtn(_ sender: Any) {
        router?.none()
    }
    @IBAction func requestMeal(_ sender: Any) {
        router?.meal()
    }
    @IBAction func tableReservation(_ sender: Any) {
        router?.reservation()
    }
}
// MARK: - ...  View Contract
extension ReservationTypeVC: ReservationTypeViewContract {
}
