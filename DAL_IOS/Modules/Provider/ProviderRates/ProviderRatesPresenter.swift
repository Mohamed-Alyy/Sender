//
//  ProviderRatesPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ProviderRatesPresenter: BasePresenter<ProviderRatesViewContract> {
}
// MARK: - ...  Presenter Contract
extension ProviderRatesPresenter: ProviderRatesPresenterContract {
    func fetchRates(for provider: Int?) {
        let method = NetworkConfigration.EndPoint.endPoint(point: .rates, paramters: [provider ?? 0])
        NetworkManager.instance.request(method, type: .get, ProviderRatesModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchRates(for: model?.data)
                case .failure:
                    break
            }
        }
    }
}
