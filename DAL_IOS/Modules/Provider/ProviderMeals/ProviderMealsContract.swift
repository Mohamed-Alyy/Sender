//
//  ProviderMealsContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ProviderMealsPresenterContract: PresenterProtocol {
    func fetchProducts(for menuCategoryId: Int?,providerId: Int?)
}
// MARK: - ...  View Contract
protocol ProviderMealsViewContract: PresentingViewProtocol {
    func didFetchProducts(for list: [ProviderCategoriesMealsDatum]?)
}
// MARK: - ...  Router Contract
protocol ProviderMealsRouterContract: Router, RouterProtocol {
    func filter()
    func meal(for meal: ProviderCategoriesMealsDatum?)
}
