//
//  VerifyCodeVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class VerifyCodeVC: BaseController {
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var code1Txf: UITextField!
    @IBOutlet weak var code2Txf: UITextField!
    @IBOutlet weak var code3Txf: UITextField!
    @IBOutlet weak var code4Txf: UITextField!
    
    var presenter: VerifyCodePresenter?
    var router: VerifyCodeRouter?
    var verifyInputs: VerifyCodeInputs?
    var timer: TimeHelper?
    var code: Int?
    var forgetPassword: Bool = false
    var userId: Int = 0
    var mobile: String?
    var countryCode: String?
    var canResend: Bool = false
}

// MARK: - ...  LifeCycle
extension VerifyCodeVC {
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
        setupResendBtn(counter: 0)
        setupTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
        timer?.stopTimer()
    }
}
// MARK: - ...  Functions
extension VerifyCodeVC {
    func setup() {
        mobileLbl.text = "\(countryCode ?? "") \(mobile ?? "")"
        verifyInputs = .init()
        verifyInputs?.dataSource = self
        
    }
    func setupResendBtn(counter: Int) {
        let sentInTitle = canResend == true ? "Send again".localized : "\("Sent in".localized) \(counter.fromatSecondsFromTimer())"
        resendBtn.setTitle("\("No code received?".localized) \(sentInTitle)", for: .normal)
        let text = resendBtn.title(for: .normal)
        let attrText = text?.colorOfWord("No code received?".localized, with: R.color.textColor() ?? .clear)
        resendBtn.setAttributedTitle(attrText, for: .normal)
    }
    func setupTimer() {
        timer = .init(seconds: 1, numberOfCycle: 120, closure: { [weak self] second in
            if second == 0 {
                self?.timer?.stopTimer()
                self?.canResend = true
            }
            self?.setupResendBtn(counter: second)
        })
    }
}
extension VerifyCodeVC {
    @IBAction func next(_ sender: Any) {
        if verifyInputs?.code?.int != code {
            self.openConfirmation(title: "Code is incorrect".localized)
        } else {
            startLoading()
            if forgetPassword {
                presenter?.verifyCodeForgotPassword(user_id: userId, code: code)
            }else{
                presenter?.verifyCode(mobile: mobile, code: code)
            }
            
        }
    }
    @IBAction func resend(_ sender: Any) {
        if canResend {
            startLoading()
            presenter?.resendCode(mobile: mobile)
        }
    }
}
// MARK: - ...  View Contract
extension VerifyCodeVC: VerifyCodeViewContract, PopupConfirmationViewContract {
    func didResend(code: Int?) {
        self.code = code
        stopLoading()
        canResend = false
        setupTimer()
    }
    
    func didVerify(secret_code: String) {
        stopLoading()
        if forgetPassword {
            router?.resetPassword(secret_code: secret_code)
        } else {
            router?.completeRegister()
        }
    }
    
    func didError(error: String?) {
        stopLoading()
        openConfirmation(title: error)
    }
}

extension VerifyCodeVC: VerifyCodeInputsDataSource {
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, view: Bool?) -> UIView? {
        return self.view
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, txfs: Bool?) -> [UITextField] {
        return [code1Txf, code2Txf, code3Txf, code4Txf]
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, textBorder: Bool?) -> UIColor {
        return R.color.fourthColor() ?? .clear
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, completeBorder: Bool?) -> UIColor {
        return R.color.borderColor1() ?? .clear
    }
}
