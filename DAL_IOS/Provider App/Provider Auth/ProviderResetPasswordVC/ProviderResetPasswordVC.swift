//
//  ProviderResetPasswordVC.swift
//  DAL_IOS
//
//  Created by KhaleD HuSsien on 18/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderResetPasswordVC: UIViewController {
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmNewPasswordTF: UITextField!
    var secret_code: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.secret_code!)
    }
    
    
    @IBAction func confirmNewPasswordBtnTapped(_ sender: UIButton) {
        confirmNewPassword()
    }
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController()
    }
    func getAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    private func confirmNewPassword(){
        if let newPassword = self.newPasswordTF.text , !newPassword.isEmpty,
           let confirmNewPassword = self.confirmNewPasswordTF.text,!confirmNewPassword.isEmpty ,newPassword == confirmNewPassword ,
           let secret_code = self.secret_code ,
           let userID = UserDefaults().object(forKey: "userID")as? Int{
            print(userID)
            print(secret_code)
            NetworkManager.instance.paramaters["secret_code"] = secret_code
            NetworkManager.instance.paramaters["new_password"] = newPassword
            NetworkManager.instance.paramaters["user_id"] = userID
            NetworkManager.instance.request(.saveResetPassword, type: .post, BaseModel<String>.self) {  (response) in
                switch response {
                case .success(let model):
                    print(model!)
                    self.getAlert(title: "Congratulations :)", message: "Your password updated Successfuly")
                case .failure(let error):
                    print(error!)
                    self.getAlert(title: "Error :(", message: error?.localizedDescription ?? "error")
                }
            }
        }
    }
}
