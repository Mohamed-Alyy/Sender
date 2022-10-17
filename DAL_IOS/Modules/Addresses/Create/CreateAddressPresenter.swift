//
//  CreateAddressPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import Alamofire


// MARK: - ...  Presenter
class CreateAddressPresenter: BasePresenter<CreateAddressViewContract> {
}
// MARK: - ...  Presenter Contract
extension CreateAddressPresenter: CreateAddressPresenterContract {
    func fetchCities() {
        NetworkManager.instance.request(.cities, type: .get, CitiesModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchCities(for: model)
                case .failure:
                    break
            }
        }
    }
    func create() {
        guard let view = view as? CreateAddressVC else { return }
//        guard view.locationLb.text != "Location".localized else {return}
//        if !view.validate(txfs: [view.addressNameTxf, view.detailsTxf]) {
//            return
//        }
        view.startLoading()
        var paramaters = view.paramters
        if let addressName = view.addressNameTxf.text, addressName != "" {
            paramaters["name"] = addressName
        }
        paramaters["type"] = view.addressesTitle.getElement(at:view.selectedTitleIndex)
        paramaters["description"] = view.detailsTxf.text
        paramaters["is_default"] = "0"
        NetworkManager.instance.paramaters = paramaters 
        NetworkManager.instance.request(.myAddresses, type: .post, BaseModel<String>.self) { [weak self] (response) in
            self?.view?.stopLoading()
            switch response {
                case .success(let model):
                    self?.view?.didCreate()
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
    func edit() {
        guard let view = view as? CreateAddressVC else { return }
        if !view.validate(txfs: [view.addressNameTxf, view.detailsTxf]) {
            return
        }
        view.startLoading()
        var paramaters = view.paramters
        paramaters["name"] = view.addressNameTxf.text
        paramaters["type"] = view.addressesTitle.getElement(at:view.selectedTitleIndex)
        paramaters["description"] = view.detailsTxf.text
        paramaters["is_default"] = "0"
        NetworkManager.instance.paramaters = paramaters
        let method = NetworkConfigration.EndPoint.endPoint(point: .myAddresses, paramters: [view.oldAddress?.id ?? 0])
        NetworkManager.instance.request(method, type: .post, BaseModel<String>.self) { [weak self] (response) in
            self?.view?.stopLoading()
            switch response {
                case .success(let model):
                    self?.view?.didCreate()
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
}

