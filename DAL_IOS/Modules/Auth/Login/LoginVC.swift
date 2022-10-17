//
//  LoginVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class LoginVC: BaseController {
    @IBOutlet weak var mobileTxf: UITextField!
    @IBOutlet weak var passwordTxf: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    var presenter: LoginPresenter?
    var router: LoginRouter?
}

// MARK: - ...  LifeCycle
extension LoginVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        setup()
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
extension LoginVC {
    func setup() {
        let text = registerBtn.title(for: .normal)
        let attrText = text?.colorOfWord("Register now".localized, with: R.color.mainColor() ?? .clear)
        registerBtn.setAttributedTitle(attrText, for: .normal)
    }
}
// MARK: - ...  Actions
extension LoginVC {
    @IBAction func login(_ sender: Any) {
        presenter?.login()
    }
    @IBAction func forgetPassword(_ sender: Any) {
        router?.forgetPassword()
    }
    @IBAction func register(_ sender: Any) {
        router?.register()
    }
    @IBAction func skip(_ sender: Any) {
        router?.skip()
    }
}
// MARK: - ...  View Contract
extension LoginVC: LoginViewContract, PopupConfirmationViewContract {
    func didLogin() {
        stopLoading()
        router?.skip()
    }
    
    func didError(error: String?) {
        openConfirmation(title: error)
    }
}
