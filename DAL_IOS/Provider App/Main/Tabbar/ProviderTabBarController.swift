//
//  ProviderTabBarController.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 11/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderTabBarController: UITabBarController,UITabBarControllerDelegate {

    // MARK: - View lifecycle
    
    
    var viewController: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.unselectedItemTintColor = .white
        let tabBar = { () -> TabBarWithCorners in
            let tabBar = TabBarWithCorners()
            tabBar.delegate = self
            return tabBar
        }()
        self.setValue(tabBar, forKey: "tabBar")
    }
    
     

    // MARK: - Setups
    
    private func addViewControllers(){
        viewControllers = [
            createTabBarItem(tabBarTitle: "More", tabBarImage: "Group 2542", viewController: ProviderMoreMenuVC.loadFromNib()),
            createTabBarItem(tabBarTitle: "Notifications", tabBarImage: "Iconly-Light-Notification", viewController: ProviderNotificationVC.loadFromNib()),
            createTabBarItem(tabBarTitle: "Home", tabBarImage: "Iconly-Light-Home", viewController: ProviderHomeVC.loadFromNib())]
    }
    
    private func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UIViewController {
        viewController.tabBarItem.title = tabBarTitle
        viewController.tabBarItem.image = UIImage(named: tabBarImage)
//        let nvg = UINavigationController(rootViewController: viewController)
        return viewController
    }

    // MARK: - Actions

    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
    }
    
    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // This is a bit dangerous if we move where 'newController' is located in the tabs, this will break.
        let homeController = viewControllers![2]
        let sideMenuController = viewControllers![0]
        // Check if the view about to load is the second tab and if it is, load the modal form instead.
//        if viewController == homeController{
//            return false
//        }else if viewController == sideMenuController{
//            let view = SideMenuRouter.createModule()
//            self.present(view, animated: true, completion: nil)
//            return false
//        }else{
//            if !isLoogedIn { showLoginAlert()}
//            return isLoogedIn
//        }

        return true
    }
}
