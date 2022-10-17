//
//  ShippingAddressPresenter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ShippingAddressPresenter: BasePresenter<ShippingAddressViewContract> {
}
// MARK: - ...  Presenter Contract
extension ShippingAddressPresenter: ShippingAddressPresenterContract {
    func fetchAddresses() {
        NetworkManager.instance.request(.myAddresses, type: .get, AddressesModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchAddresses(for: model?.data)
                case .failure:
                    break
            }
        }
    }
     
}

