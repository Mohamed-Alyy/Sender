//
//  ProviderForgetPasswordVC.swift
//  DAL_IOS
//
//  Created by KhaleD HuSsien on 18/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderForgetPasswordVC: UIViewController {
    @IBOutlet weak var mobilePhoneTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func getAlert(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    private func getToProviderVerifyCodeVC(){
        if let mobilePhone = mobilePhoneTF.text{
            if mobilePhone.isEmpty {
                getAlert(message: "Mobile is required")
                return
            }
            if mobilePhone.count != 9 {
                getAlert(message: "The mobile number must be 9 digits")
                return
            }
            NetworkManager.instance.paramaters["phone"] = mobilePhone
            NetworkManager.instance.request(.forgotPasswordStep1, type: .get, ForgetPasswordModel.self) { [weak self] (response) in
                switch response {
                case .success(let model):
                    guard let model = model ,let codeID = model.user_id else{return}
                    let controller = ProviderVerifyCodeVC.loadFromNib()
                    controller.mobilePhone = mobilePhone
                    UserDefaults.standard.set(codeID, forKey: "userID")
                    controller.modalTransitionStyle = .flipHorizontal
                    self?.navigationController?.pushViewController(controller, animated: true)
                    
                case .failure(let error):
                    self?.getAlert(message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    @IBAction func confirmMobilePhoneTapped(_ sender: UIButton) {
        getToProviderVerifyCodeVC()
        
    }
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController()
    }
}

//501111111
//510010055

