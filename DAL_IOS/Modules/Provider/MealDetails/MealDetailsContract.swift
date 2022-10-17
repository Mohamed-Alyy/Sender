//
//  MealDetailsContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol MealDetailsPresenterContract: PresenterProtocol {
    func fetchMeal(mealID: Int?)
}
// MARK: - ...  View Contract
protocol MealDetailsViewContract: PresentingViewProtocol {
    func didFetchMeal(for meal: ProviderCategoriesMealsDatum?)
}
// MARK: - ...  Router Contract
protocol MealDetailsRouterContract: Router, RouterProtocol {
    func extras()
    func cart(providerId :Int)
}
