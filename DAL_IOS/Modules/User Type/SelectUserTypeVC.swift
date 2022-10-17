//
//  SelectUserTypeVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 10/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class SelectUserTypeVC: UIViewController {

    @IBOutlet weak var providerView: UIView!
    @IBOutlet weak var providerLbl: UILabel!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prefs.set(false, forKey: UD.PrefKeys.userTypeIsProvider)
        // Do any additional setup after loading the view.
    }
 

}
// MARK: - ...  Functions
extension SelectUserTypeVC {
    func setup() {
        if UserDefultHelper.instance.userTypeIsProvider == true {
            providerView.borderWidth = 1
            userView.borderWidth = 0
            providerLbl.textColor = R.color.mainColor()
            userLbl.textColor = .black
        } else {
            providerView.borderWidth = 0
            userView.borderWidth = 1
            providerLbl.textColor = .black
            userLbl.textColor = R.color.mainColor()
        }
    }
    
    @IBAction func didTappedProvider(_ sender: Any) {
        prefs.set(true, forKey: UD.PrefKeys.userTypeIsProvider)
        setup()
    }
    
    @IBAction func didTappedUser(_ sender: Any) {
        prefs.set(false, forKey: UD.PrefKeys.userTypeIsProvider)
        setup()
    }
    
    @IBAction func didTappedNext(_ sender: Any) {
        goToOnBoarding()
    }
    
    private func goToOnBoarding(){
        let storyboard = UIStoryboard(name: "OnBoardingStoryboard", bundle: nil)
        guard let rootViewController = storyboard.instantiateInitialViewController() else { return  }
        rootViewController.modalPresentationStyle = .fullScreen
        self.present(rootViewController, animated: true)
        
    }
}
