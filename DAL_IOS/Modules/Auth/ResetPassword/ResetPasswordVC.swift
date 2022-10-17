//
//  ResetPasswordVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ResetPasswordVC: BaseController {
    @IBOutlet weak var passwordTxf: UITextField!
    @IBOutlet weak var confirmPasswordTxf: UITextField!
    var presenter: ResetPasswordPresenter?
    var router: ResetPasswordRouter?
    var mobile: String?
    var countryCode: String?
    var secret_code: String?
    var userId: Int?
}

// MARK: - ...  LifeCycle
extension ResetPasswordVC {
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ResetPasswordVC {
    func setup() {
    }
}
extension ResetPasswordVC {
    @IBAction func confirm(_ sender: Any) {
        presenter?.resetPassword()
    }
}
// MARK: - ...  View Contract
extension ResetPasswordVC: ResetPasswordViewContract, PopupConfirmationViewContract {
    func didReset(message: String?) {
        stopLoading()
        openConfirmation(title: message, btns: [.agree], onAgreeClosure: {
            self.router?.login()
        })
    }
    
    func didError(error: String?) {
        stopLoading()
        openConfirmation(title: error)
    }
}
