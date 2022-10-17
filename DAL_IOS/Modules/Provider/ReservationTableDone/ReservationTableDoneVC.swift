//
//  ReservationTableDoneVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ReservationTableDoneVC: BaseController {
    @IBOutlet weak var reservationLbl: UILabel!
    var presenter: ReservationTableDonePresenter?
    var router: ReservationTableDoneRouter?
    var book: ReservationTableModel?
    weak var delegate: ReservationDoneDelegate?
}

// MARK: - ...  LifeCycle
extension ReservationTableDoneVC {
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
extension ReservationTableDoneVC {
    func setup() {
        reservationLbl.text = "\("Day".localized) \(book?.day ?? "") \("from month".localized) \(book?.month ?? "") \("hour".localized) \(book?.hourText ?? "") \("For numbers of individuals".localized) \(book?.persons ?? 0)"
    }
    override func backBtn(_ sender: Any) {
        router?.didDone()
    }
    @IBAction func reservations(_ sender: Any) {
        router?.didDone(go: true)
    }
}
// MARK: - ...  View Contract
extension ReservationTableDoneVC: ReservationTableDoneViewContract {
}
