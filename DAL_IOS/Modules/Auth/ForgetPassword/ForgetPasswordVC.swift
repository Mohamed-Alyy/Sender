//
//  ForgetPasswordVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ForgetPasswordVC: BaseController {
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var mobileTxf: UITextField!
    @IBOutlet weak var mobileView: UIView!
    var presenter: ForgetPasswordPresenter?
    var router: ForgetPasswordRouter?
}

// MARK: - ...  LifeCycle
extension ForgetPasswordVC {
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
extension ForgetPasswordVC {
    func setup() {
        mobileView.semanticContentAttribute = .forceLeftToRight
        mobileTxf.textAlignment = .left
    }
}
extension ForgetPasswordVC {
    @IBAction func next(_ sender: Any) {
        if !validate(txfs: [mobileTxf]) {
            return
        }
        startLoading()
        presenter?.sendCode(mobile: mobileTxf.text)
    }
    @IBAction func countryPicker(_ sender: Any) {
    }
}
// MARK: - ...  View Contract
extension ForgetPasswordVC: ForgetPasswordViewContract, PopupConfirmationViewContract {
    func didSend(code: Int?, userId: Int) {
        stopLoading()
        router?.verify(code: code, userId: userId)
    }
    
    func didError(error: String?) {
        stopLoading()
        openConfirmation(title: error)
    }
}
