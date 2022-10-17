//
//  ProfileVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ProfileVC: BaseController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLb: UILabel!
    @IBOutlet weak var createDateLb: UILabel!
    @IBOutlet weak var bottomView: UIView!
    var presenter: ProfilePresenter?
    var router: ProfileRouter?

}

// MARK: - ...  LifeCycle
extension ProfileVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserRoot.token() == nil {
            UserRoot.authroize() {
                self.tabBarController?.selectedIndex = 0
            }
            return
        }
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        presenter?.fetch()
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ProfileVC {
    func setup() {
        userNameLb.text = UserRoot.fetchUser()?.name
        createDateLb.text = "date of registration".localized + " " + (UserRoot.fetchUser()?.createdAt ?? "")
        profileImage.setImage(url: UserRoot.fetchUser()?.avatar)
        bottomView.roundCorners([.topLeft,.topRight], radius: 10)
    }
}
extension ProfileVC {
    @IBAction func logout(_ sender: Any) {
        router?.logout()
    }
    @IBAction func edit(_ sender: Any) {
        router?.editProfile()
    }
    @IBAction func favorites(_ sender: Any) {
        router?.favorites()
    }
    
    @IBAction func myCards(_ sender: Any) {
        router?.cards()
    }
    
    @IBAction func reservations(_ sender: Any) {
        router?.reservations()
    }
    @IBAction func addresses(_ sender: Any) {
        router?.addresses()
    }
    
    @IBAction
    func didTappedLoyaltyPoints(_ sender: UIButton){
        router?.goToLoyaltyPoints()
    }
    
    @IBAction func didTappedWallet(_ sender: Any) {
        router?.goToWallet()
    }
}
// MARK: - ...  View Contract
extension ProfileVC: ProfileViewContract {
    func didFetch() {
        setup()
    }
}
