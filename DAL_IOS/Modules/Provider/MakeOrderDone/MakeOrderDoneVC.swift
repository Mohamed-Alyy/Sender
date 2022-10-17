//
//  MakeOrderDoneVC.swift
//  DAL_IOS
//
//  Created by Mabdu on 24/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MakeOrderDoneVC: BaseController {
    @IBOutlet weak var reservationLbl: UILabel!
    var presenter: MakeOrderDonePresenter?
    var router: MakeOrderDoneRouter?
    weak var delegate: OrderDoneDelegate?
}

// MARK: - ...  LifeCycle
extension MakeOrderDoneVC {
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
extension MakeOrderDoneVC {
    func setup() {
        
    }
    override func backBtn(_ sender: Any) {
        router?.didDone()
    }
    @IBAction func orders(_ sender: Any) {
        router?.didDone(go: true)
    }
}
// MARK: - ...  View Contract
extension MakeOrderDoneVC: MakeOrderDoneViewContract {
}
