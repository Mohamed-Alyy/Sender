//
//  ProviderMoreMenuVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 11/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderMoreMenuVC: UIViewController {
    // MARK: - Variables
    private let cellHeight: CGFloat = 50
    
    lazy var menuItemType: [ProviderMenuItemType] = {
        return ProviderMenuItemType.allCases
    }()
    
    var showMawared: Bool = false

  // MARK: - IBOutlets
  @IBOutlet private weak var profileIV: UIImageView!
  @IBOutlet private weak var tableView: UITableView!

  // MARK: - Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = true
    registerTableView()
    loadTheme()
    profileIV.setImage(url: UserRoot.fetchUser()?.avatar)
  }
   
    
    private func registerTableView(){
     tableView.register(cell: ProviderMoreMenuCell.self)
      tableView.dataSource = self
      tableView.delegate = self
      tableView.backgroundColor = .clear
      tableView.tableFooterView = UIView()
      tableView.separatorStyle = .none
    }

  private func loadTheme() {
      profileIV.layer.cornerRadius = profileIV.frame.height / 2
      profileIV.clipsToBounds = true
  }
 
}

// MARK: - -- Tableview Data Source ----
extension ProviderMoreMenuVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuItemType.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell: ProviderMoreMenuCell = tableView.dequeue(indexPath: indexPath)
      cell.setupViews(for: menuItemType.getElement(at: indexPath.row))
    return cell
  }

}

// MARK: - -- Tableview delegate ----
extension ProviderMoreMenuVC: UITableViewDelegate {
  // did select row method
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer { tableView.deselectRow(at: indexPath, animated: true) }
    let item = menuItemType[indexPath.row]
    // call the handler of the selected row
    var controller: UIViewController?
    switch item {
    case .home: controller = HomeVC.loadFromNib()
      case .serviceProviderInformation: controller = nil
      case .orders: controller = nil
      case .packages: controller = nil
      case .qrCode: controller = nil
      case .settings: controller = nil
      case .changeLangauge: break
      case .contactUs: controller = nil
      case .aboutUs: controller = nil
      case .usagePrivacyPolicy: controller = nil
      case .logout: didSelectLogout()
    }
    if let controller = controller {
      navigationController?.pushViewController(controller, animated: true)
    }
  }
  
  func didSelectLogout() {   }
}
