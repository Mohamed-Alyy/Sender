//
//  AddressesPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class AddressesPresenter: BasePresenter<AddressesViewContract> {
}
// MARK: - ...  Presenter Contract
extension AddressesPresenter: AddressesPresenterContract {
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
    func deleteAddress(for address: Int?) {
        let method = NetworkConfigration.EndPoint.endPoint(point: .myAddresses, paramters: [address ?? 0])
        NetworkManager.instance.request(method, type: .delete, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success:
                    break
                case .failure:
                    break
            }
        }
    }
    
    
    func setAddressAsDefult(for address: Int?) {
        view?.startLoading()
        let method = NetworkConfigration.EndPoint.endPoint(point: .myAddresses, paramters: [address ?? 0,"default"])
        NetworkManager.instance.request(method, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success:
                self?.fetchAddresses()
                case .failure:
                    break
            }
        }
    }
}

