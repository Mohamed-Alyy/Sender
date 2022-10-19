//
//  ProviderVerifyCodeVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 11/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderVerifyCodeVC: UIViewController {
    
    @IBOutlet weak var mobilePhoneLable: UILabel!
    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var num4: UITextField!
    @IBOutlet weak var num3: UITextField!
    @IBOutlet weak var num2: UITextField!
    @IBOutlet weak var num1: UITextField!
    var mobilePhone: String?
    var canResend: Bool = false
    var timer: TimeHelper?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let phoneNum = mobilePhone {
            self.mobilePhoneLable.text = "+966 \(phoneNum)"
        }
        setupResendBtn(counter: 0)
        setupTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.stopTimer()
    }
    //MARK: - private functions
    func didResend() {
        stopLoading()
        canResend = false
        setupTimer()
    }
    func setupResendBtn(counter: Int) {
        let sentInTitle = canResend == true ? "Send again".localized : "\("Sent in".localized) \(counter.fromatSecondsFromTimer())"
        resendCodeBtn.setTitle("\("No code received?".localized) \(sentInTitle)", for: .normal)
        let text = resendCodeBtn.title(for: .normal)
        let attrText = text?.colorOfWord("No code received?".localized, with: R.color.textColor() ?? .clear)
        resendCodeBtn.setAttributedTitle(attrText, for: .normal)
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
    private func getVerifyCode(){
        if let mobilePhone = self.mobilePhone, let userID = UserDefaults().object(forKey: "userID")as? Int,
           let num1 = num1.text ,
           let num2 = num2.text ,
           let num3 = num3.text ,
           let num4 = num4.text{
            print("Mobile: \(mobilePhone)")
            print("user id : \(userID)")
            let code = num1+num2+num3+num4
            NetworkManager.instance.paramaters["user_id"] = userID
            NetworkManager.instance.paramaters["code"] = code
            NetworkManager.instance.request(.forgotPasswordStep2, type: .post, VerifyCodeResetPasswordModel.self) { [weak self] result in
                switch result{
                case .success(let model):
                    guard let model = model else{return}
                    let controller = ProviderResetPasswordVC.loadFromNib()
                    controller.secret_code = model.secret_code
                    controller.modalTransitionStyle = .flipHorizontal
                    controller.navigationController?.navigationBar.isHidden = true
                    self?.navigationController?.pushViewController(controller, animated: true)
                    print("model: \(model)")
                case .failure(let error):
                    if let error = error {
                        self?.showAlert(message: error.localizedDescription ,title: "Error")
                    }
                }
            }
        }
    }
    func resendCode(mobile: String?) {
        NetworkManager.instance.paramaters["phone"] = mobile
        NetworkManager.instance.request(.forgotPasswordStep1, type: .get, ForgetPasswordModel.self) { (response) in
            switch response {
            case .success(let model):
                print("code resend:)")
                self.didResend()
                guard let model = model , let message = model.message else{return}
                self.showAlert(message: "\(message) + \(model.wait_for ?? 0)", title: "Error")
            case .failure(let error):
                if let error = error {
                    self.showAlert(message: error.localizedDescription, title: "Error")
                }
            }
        }
    }
    func showAlert(message: String,title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(title: "OK", style: .default, isEnabled: true, handler: nil)
        self.present(alert, animated: true)
    }
    //MARK: - Actions
    @IBAction func verifyCodeBtnTapped(_ sender: UIButton) {
        getVerifyCode()
    }
    @IBAction func resendVerifyCode(_ sender: UIButton) {
        guard canResend == true else{return}
        if let mobilePhone = self.mobilePhone{
            resendCode(mobile: mobilePhone)
        }
    }
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController()
    }
}
