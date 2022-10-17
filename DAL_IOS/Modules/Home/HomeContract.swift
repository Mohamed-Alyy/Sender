//
//  HomeContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/29/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol HomePresenterContract: PresenterProtocol {
    func fetchHome()
    func fetchCategories()
}
// MARK: - ...  View Contract
protocol HomeViewContract: PresentingViewProtocol { 
    func didFetchCategories(model: [CategoriesResult]?)
    func didFetchAds(model: [AdsResult]?)
    func didFetchSuggestedProducts(model: [ProviderCategoriesMealsDatum]?)
    func didFetchUser()
    
}
// MARK: - ...  Router Contract
protocol HomeRouterContract: Router, RouterProtocol {
    func search(text: String?,for category: CategoriesResult?)
    func category(for category: CategoriesResult)
    func product(for mealID: Int?)
    func rateOrder()
    func openProviderCart()
}
