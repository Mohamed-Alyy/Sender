//
//  MealExtrasContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol MealExtrasPresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol MealExtrasViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol MealExtrasRouterContract: Router, RouterProtocol {
    func didPlusExtras(didEdit: Bool?)
}

protocol MealExtrasDelegate: AnyObject {
    func mealExtras(_ delegate: MealExtrasDelegate?, for meal: ProviderCategoriesMealsDatum?)
}
