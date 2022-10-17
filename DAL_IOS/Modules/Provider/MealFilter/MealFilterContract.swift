//
//  MealFilterContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  Presenter Contract
protocol MealFilterPresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol MealFilterViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol MealFilterRouterContract: Router, RouterProtocol {
    func didFilter()
}

protocol MealFilterDelegate: class {
    func mealFilter(for subCategory: Provider.SubCategory?, by sort: Sort?, minPrice: CGFloat?, maxPrice: CGFloat?)
}
