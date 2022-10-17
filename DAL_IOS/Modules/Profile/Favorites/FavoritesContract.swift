//
//  FavoritesContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol FavoritesPresenterContract: PresenterProtocol {
    func fetchFavorites()
}
// MARK: - ...  View Contract
protocol FavoritesViewContract: PresentingViewProtocol {
    func didFetch(for list: [ProvidersResult]?)
}
// MARK: - ...  Router Contract
protocol FavoritesRouterContract: Router, RouterProtocol {
    func provider(for provider: ProvidersResult?) 
}
