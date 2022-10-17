//
//  SearchFilterContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol SearchFilterPresenterContract: PresenterProtocol {
    func fetchLookup()
    func fetchCities(areasId: Int)
}
// MARK: - ...  View Contract
protocol SearchFilterViewContract: PresentingViewProtocol {
    func didFetchCategories(model: [CategoriesResult]?)
    func didFetchMenuCategories(model: [CategoriesResult]?)
    func didFetchAreas(model: [AreasDatum]?)
    func didFetchCities(model: [CitiesListModel]?)
    func reloadFilterView()
    
}
// MARK: - ...  Router Contract
protocol SearchFilterRouterContract: Router, RouterProtocol {
    func didFilter(paramters: [String: Any]?)
}

protocol SearchFilterDelegate: AnyObject {
    func searchFilter(_ filter: SearchFilterDelegate?, for options: [String: Any])
}
