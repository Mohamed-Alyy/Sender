//
//  AboutUsPresenter.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class AboutUsPresenter: BasePresenter<AboutUsViewContract> {
}
// MARK: - ...  Presenter Contract
extension AboutUsPresenter: AboutUsPresenterContract {
    func settings() {
        NetworkManager.instance.request(.about, type: .get, AboutModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                self?.view?.didFetch(for: model)
                case .failure:
                    break
            }
        }
    }
}
