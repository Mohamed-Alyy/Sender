//
//  CompleteRegisterVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class CompleteRegisterVC: BaseController {
    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var passwordTxf: UITextField!
    @IBOutlet weak var confirmPasswordTxf: UITextField!
    @IBOutlet weak var agreeBtn: RadioButton!

    var presenter: CompleteRegisterPresenter?
    var router: CompleteRegisterRouter?
    var mobile: String?
    var countryCode: String?
    var isAgree: Bool = false
}

// MARK: - ...  LifeCycle
extension CompleteRegisterVC {
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
        setupRadioBtns()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension CompleteRegisterVC {
    func setup() {
        passwordTxf.textContentType = .oneTimeCode
        confirmPasswordTxf.textContentType = .oneTimeCode
    }
    func setupRadioBtns() {
        agreeBtn.onSelect { [weak self] in
            self?.isAgree = true
        }
        agreeBtn.onDeselect { [weak self] in
            self?.isAgree = false
        }
    }
}
extension CompleteRegisterVC {
    @IBAction func agreeTerms(_ sender: Any) {
        router?.terms()
    }
    @IBAction func register(_ sender: Any) {
        if !isAgree {
            openConfirmation(title: "Please agree the terms first".localized)
            return
        }
        presenter?.register()
    }
    
    @IBAction func didTappedShow_hidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let isSelected = sender.isSelected
        passwordTxf.isSecureTextEntry = !isSelected
    }
    
    @IBAction func didTappedShow_hideConfirmPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let isSelected = sender.isSelected
         confirmPasswordTxf.isSecureTextEntry = !isSelected
    }
}
// MARK: - ...  View Contract
extension CompleteRegisterVC: CompleteRegisterViewContract, PopupConfirmationViewContract {
    func didRegister() {
        stopLoading()
        router?.home()
    }
    func didError(error: String?) {
        stopLoading()
        openConfirmation(title: error)
    }
}
