//
//  AddressesContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol AddressesPresenterContract: PresenterProtocol {
    func fetchAddresses()
    func deleteAddress(for address: Int?)
    func setAddressAsDefult(for address: Int?)
}
// MARK: - ...  View Contract
protocol AddressesViewContract: PresentingViewProtocol {
    func didFetchAddresses(for list: [AddressesModel.Datum]?)
}
// MARK: - ...  Router Contract
protocol AddressesRouterContract: Router, RouterProtocol {
    func dismiss()
    func didCreate()
    func didCompleteOrder(for address: Int?)
}

protocol AddressesDelegate: AnyObject {
    func addresses(_ delegate: AddressesDelegate?, didCreate create: Bool)
    func addresses(_ delegate: AddressesDelegate?, for address: AddressesModel.Datum?)
    func addresses(_ delegate: AddressesDelegate?, for address: Int?)
}

extension AddressesDelegate {
    func addresses(_ delegate: AddressesDelegate?, for address: AddressesModel.Datum?) { }
}
