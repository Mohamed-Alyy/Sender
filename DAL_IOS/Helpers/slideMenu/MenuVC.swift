//
//  MenuVC.swift
//  FashonDesign
//
//  Created by Mohamed Abdu on 4/25/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//#import "SWRevealViewController.h"

import UIKit

enum MenuEnum: String {
    case home
    case share
    case lang
    case contact
    case about
    case faq
    case logout
}

class MenuModel {
    var name: String!
    var index: MenuEnum?
    var key: UIStoryboard!
    var imageOn: UIImage?
    var imageOff: UIImage?

    init(_ name: String, _ key: UIStoryboard!, _ imageOn: UIImage? = nil, _ imageOff: UIImage? = nil, _ index: MenuEnum? = nil) {
        self.name = name
        self.key = key
        self.index = index
        self.imageOn = imageOn
        self.imageOff = imageOff
    }

}
class MenuVC: BaseController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var menuCollection: UITableView!

    static var currentPage: String = "HomeNav"
    static var currentIndex: MenuEnum? = .home
    var menu: [MenuModel] = []
    static func resetMenu() {
        MenuVC.currentPage = "HomeNav"
    }
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        setupMenu()
        if menuCollection != nil {
            menuCollection.delegate = self
            menuCollection.dataSource = self
        }
        //userName.text = "\(UserRoot.instance.result?.first_name ?? "") \(UserRoot.instance.result?.last_name ?? "" )"
        //userImage.setImage(url: UserRoot.instance.result?.image)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userImage.setImage(url: UserRoot.fetchUser()?.avatar)
    }
    func setupMenu() {

        menu.append(MenuModel("Home".localized, R.storyboard.homeStoryboard(),#imageLiteral(resourceName: "Group 2661"),#imageLiteral(resourceName: "Group 2661"),.home))
        menu.append(MenuModel("Share".localized, R.storyboard.homeStoryboard(),#imageLiteral(resourceName: "Group 2625"),#imageLiteral(resourceName: "Group 2625"),.share))
        menu.append(MenuModel("Change langauge".localized, R.storyboard.languageStoryboard(),#imageLiteral(resourceName: "Group 2626"),#imageLiteral(resourceName: "Group 2626"),.lang))
        menu.append(MenuModel("Contact us".localized, R.storyboard.contactUsStoryboard(),#imageLiteral(resourceName: "Group 2627"),#imageLiteral(resourceName: "Group 2627"),.contact))
        menu.append(MenuModel("About us".localized, R.storyboard.aboutUsStoryboard(),#imageLiteral(resourceName: "Group 2628"),#imageLiteral(resourceName: "Group 2628"),.about))
        menu.append(MenuModel("Terms and Conditions".localized, R.storyboard.faqStoryboard(),#imageLiteral(resourceName: "Group 2629"),#imageLiteral(resourceName: "Group 2629"),.faq))
        menu.append(MenuModel("Logout".localized, R.storyboard.homeStoryboard(),#imageLiteral(resourceName: "Group 2622"),#imageLiteral(resourceName: "Group 2622"),.logout))
    }
    func clickOnMenu(menuItem: MenuModel) {
        MenuVC.currentIndex = menuItem.index
        if menuItem.index == .logout {
            UserRoot.logout()
            Router.instance.restart()
        } else if menuItem.index == .share {
            Common().shareApp()
        } else if menuItem.index == .home {
            Router.instance.restart(storyboard: menuItem.key)
        } else {
            //MenuVC.currentPage = menuItem.key
            guard let scene = menuItem.key.instantiateInitialViewController() else { return }
            push(scene)
        }
    }

    @IBAction func close(_ sender: Any) {
        if let visibleViewController = SideMenuTransition.visibleViewController {
            visibleViewController.dismiss(animated: true, completion: nil)
        }
    }
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(type: MenuCell.self, indexPath, register: false)
        if MenuVC.currentIndex == menu[indexPath.item].index {
            //cell.contentView.backgroundColor = UIColor.colorRGB(red: 239, green: 239, blue: 239)
        }
        cell.menu = menu[indexPath.item]
        cell.setup()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.clickOnMenu(menuItem: menu[indexPath.item])
    }

}
