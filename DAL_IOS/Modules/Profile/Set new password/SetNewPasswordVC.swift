//
//  SetNewPasswordVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 02/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

// MARK: - ...  ViewController - Vars
class SetNewPasswordVC: BaseController {
    @IBOutlet weak var newPasswordTxf: UITextField!
    @IBOutlet weak var oldPasswordTxf: UITextField!
    @IBOutlet weak var confirmNewPasswordTxf: UITextField!
    var presenter: SetNewPasswordPresenter?
    var router: SetNewPasswordRouter?
    var mobile: String?
    var countryCode: String?
    var secret_code: String?
}

// MARK: - ...  LifeCycle
extension SetNewPasswordVC {
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
extension SetNewPasswordVC {
    func setup() {
    }
}
extension SetNewPasswordVC {
    @IBAction func didTappedSave(_ sender: Any) {
        presenter?.resetPassword()
    }
    
    @IBAction func didTappedShow_hideOldPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let isSelected = sender.isSelected
        oldPasswordTxf.isSecureTextEntry = !isSelected
    }
    
    @IBAction func didTappedShow_hideNewPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let isSelected = sender.isSelected
        newPasswordTxf.isSecureTextEntry = !isSelected
    }
    
    @IBAction func didTappedShow_hideConfirmNewPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let isSelected = sender.isSelected
         confirmNewPasswordTxf.isSecureTextEntry = !isSelected
    }
}
// MARK: - ...  View Contract
extension SetNewPasswordVC: SetNewPasswordViewContract, PopupConfirmationViewContract {
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

