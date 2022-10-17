//
//  CreateAddressContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol CreateAddressPresenterContract: PresenterProtocol {
    func create()
}
// MARK: - ...  View Contract
protocol CreateAddressViewContract: PresentingViewProtocol {
    func didCreate()
    func didError(error: String?)
    func didFetchCities(for model: CitiesModel?)
}
// MARK: - ...  Router Contract
protocol CreateAddressRouterContract: Router, RouterProtocol {
    func back()
    func didCreate()
    func openMap()
}

protocol CreateAddressDelegate: class {
    func createAddresses(_ delegate: CreateAddressDelegate?, didCreate create: Bool)
}
