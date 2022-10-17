//
//  TabBar.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
class CustomTabBar: UITabBarController,UITabBarControllerDelegate {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        delegate = self
        tabBar.shadowImage = UIImage() // this removes the top line of the tabBar
        tabBar.backgroundImage = UIImage() // this changes the UI backdrop view of tabBar to transparent
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: ThemeApp.Fonts.regularFont(size: 16)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
    }
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(didCreateOrder), name: Notification.Name("CreateOrder"), object: nil)
    }
    
    @objc
    func didCreateOrder(){
        self.selectedIndex = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // This is a bit dangerous if we move where 'newController' is located in the tabs, this will break.
        
//        let home = viewControllers![0]
        let personal = viewControllers![1]
        let notification = viewControllers![2]
        let orders = viewControllers![3]
        // Check if the view about to load is the second tab and if it is, load the modal form instead.
        if viewController == personal || viewController == notification || viewController == orders {
            if UserRoot.token() != nil {
                return true
            }else{
                let scene = UIApplication.topViewController() as? BaseController
                PopupConfirmationVC.confirmationPOPUP(view: scene, title: "You must be logged in first!".localized, btns: [.agree, .skip]) {
                } onAgreeClosure: {
                    Router.instance.unAuthorized()
                }
                return false
            }
        }else{
            return true
        }
        
         
    }
    
}

