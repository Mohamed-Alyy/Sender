//
//  ShippingAddressContract.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ShippingAddressPresenterContract: PresenterProtocol {
    func fetchAddresses()
}
// MARK: - ...  View Contract
protocol ShippingAddressViewContract: PresentingViewProtocol {
    func didFetchAddresses(for list: [AddressesModel.Datum]?)
}
// MARK: - ...  Router Contract
protocol ShippingAddressRouterContract: Router, RouterProtocol {
    func dismiss()
    func didCreate()
    func didCompleteOrder(checkoutModel: CheckoutModel)
}

 
