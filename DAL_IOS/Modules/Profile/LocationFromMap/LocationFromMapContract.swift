//
//  LocationFromMapContract.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/5/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol LocationFromMapPresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol LocationFromMapViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol LocationFromMapRouterContract: Router, RouterProtocol {
    func backToLocationRequestWithSuccess()
    func backToLocationRequestWithFail()
}

// MARK: - ...  Delegate Contract
protocol LocationFromMapDelegateContract: class {
    func saveLocation(lat: Double?, lng: Double?, address: String?)
    func didFailLocation()
}
