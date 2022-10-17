//
//  ProviderDetailsContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/21/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ProviderDetailsPresenterContract: PresenterProtocol {
    func fetchCategories(categoryId: Int)
    
}
// MARK: - ...  View Contract
protocol ProviderDetailsViewContract: PresentingViewProtocol {
    func didFetchCategories(model: [ProviderCategoriesDatum]?)
    func didFetchRates(model: [ProviderRatingsDatum]?)
    
}
// MARK: - ...  Router Contract
protocol ProviderDetailsRouterContract: Router, RouterProtocol {
    func rates()
    func requestMeal(with category: Provider.SubCategory?)
    func reserveTable()
    func cart(providerId :Int)
}
