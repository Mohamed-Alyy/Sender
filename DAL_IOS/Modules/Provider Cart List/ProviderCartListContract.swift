//
//  ProviderCartListContract.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 15/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ProviderCartListPresenterContract: PresenterProtocol {
    func fetchProvidersCart()
}
// MARK: - ...  View Contract
protocol ProviderCartListViewContract: PresentingViewProtocol {
    func fetchProviders(for list: [ProviderCartListDatum]?)
}
// MARK: - ...  Router Contract
protocol ProviderCartListRouterContract: Router, RouterProtocol {
    func goToCart(providerId: Int)
}
