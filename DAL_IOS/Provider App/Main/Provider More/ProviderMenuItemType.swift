//
//  MenuItemType.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 11/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

enum ProviderMenuItemType: String, CaseIterable {
  case home
  case serviceProviderInformation
  case orders
  case packages
  case qrCode
  case settings
  case changeLangauge
  case contactUs
  case aboutUs
  case usagePrivacyPolicy
  case logout

  var title: String {
    switch self {
    case .home: return "Home"
      case .serviceProviderInformation: return "Service Provider information"
      case .orders: return "Orders"
      case .packages: return "Packages"
      case .qrCode: return "Qr Code"
      case .settings: return "Settings"
      case .changeLangauge: return "Change langauge"
      case .contactUs: return "Contact us"
      case .aboutUs: return "About us"
      case .usagePrivacyPolicy: return "Usage and Privacy Policy"
      case .logout: return "Logout"
    }
  }

  var image: String {
    switch self {
      case .home: return "Home"
      case .serviceProviderInformation: return "Service Provider information"
      case .orders: return "Orders"
      case .packages: return "Packages"
      case .qrCode: return "Qr Code"
      case .settings: return "Settings"
      case .changeLangauge: return "Change langauge"
      case .contactUs: return "Contact us"
      case .aboutUs: return "About us"
      case .usagePrivacyPolicy: return "Usage and Privacy Policy"
      case .logout: return "Logout"
    }
    }
}
