//
//  ProviderCartListPresenter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 15/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

class ProviderCartListPresenter: BasePresenter<ProviderCartListViewContract> {
    
}
// MARK: - ...  Presenter Contract
extension ProviderCartListPresenter: ProviderCartListPresenterContract {
    
    func fetchProvidersCart() {
        guard let view = view as? ProviderCartListVC else { return }
        view.startLoading()
        NetworkManager.instance.request(.myCarts, type: .get, ProviderCartListModel.self) { [weak self] (response) in
            defer {view.stopLoading()}
            switch response {
                case .success(let model):
                self?.view?.fetchProviders(for: model?.data)
                case .failure:
                    break
            }
        }
    }
}
