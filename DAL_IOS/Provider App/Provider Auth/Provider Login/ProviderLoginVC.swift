//
//  ProviderLoginVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 11/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderLoginVC: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //MARK: - private func
    func showAlert(title:String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    private func login(){
        if let phone = phoneTF.text,
           let password = passwordTF.text,
           let email = emailTF.text ,
           let userId = idTF.text{
            if phone.isEmpty || password.isEmpty {
                showAlert(title: "Error", message: "Please fill all fields :)")
                return
            }
            if password.count < 6 {
                showAlert(title: "Error", message: "Phone number must have at Least 6 Digits :)")
                return
            }
            NetworkManager.instance.paramaters["phone"] = phone
            NetworkManager.instance.paramaters["password"] = password
            NetworkManager.instance.paramaters["email"] = email
            NetworkManager.instance.paramaters["national_id"] = userId
            
            NetworkManager.instance.paramaters["device_token"] = Constants.FCMTOKEN
            NetworkManager.instance.paramaters["device_type"] = "ios"
            NetworkManager.instance.paramaters["user_type"] = "provider"
            
            NetworkManager.instance.request(.login, type: .post, UserRoot.self) { result in
                switch result{
                case.failure(let error):
                    if error != nil,
                       let errorString = error?.localizedDescription{
                        self.showAlert(title: "Error :(",message: errorString)
                    }
                case.success(let user):
                    guard let user = user,
                          let userData = user.data else{return}
                    print("Congratulations")
                    self.goToProviderHomeScreen()
                    print("User Data: \(userData.name ?? "")")
                }
            }
        }
    }
    func goToProviderHomeScreen(){
        let tabBarController = ProviderTabBarController()
        tabBarController.modalTransitionStyle = .flipHorizontal
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true)
    }
    func forgetPasswordVC(){
        let controller = ProviderForgetPasswordVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    private func createNewProvider(){
        let controller = ProviderRegisterVC()
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    //MARK: - action
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        login()
    }
    @IBAction func forgetPasswordBtnTapped(_ sender: UIButton) {
        forgetPasswordVC()
    }
    
    @IBAction func newProviderTapped(_ sender: UIButton) {
        createNewProvider()
    }
}
