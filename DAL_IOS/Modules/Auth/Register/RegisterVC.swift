//
//  RegisterVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class RegisterVC: BaseController {
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var mobileTxf: UITextField!
    @IBOutlet weak var mobileView: UIView!
    var presenter: RegisterPresenter?
    var router: RegisterRouter?
    
}

// MARK: - ...  LifeCycle
extension RegisterVC {
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
extension RegisterVC {
    func setup() {
        mobileView.semanticContentAttribute = .forceLeftToRight
        mobileTxf.textAlignment = .left
    }
}
// MARK: - ...  Actions
extension RegisterVC {
    @IBAction func next(_ sender: Any) {
        if !validate(txfs: [mobileTxf]) {
            return
        }
        startLoading()
        presenter?.register(mobile: mobileTxf.text)
    }
    @IBAction func countryPicker(_ sender: Any) {
    }
}
// MARK: - ...  View Contract
extension RegisterVC: RegisterViewContract, PopupConfirmationViewContract {
    func didRegister(code: Int?) {
        stopLoading()
        router?.verify(code: code)
    }
    
    func didError(error: String?) {
        stopLoading()
        openConfirmation(title: error)
    }
}
