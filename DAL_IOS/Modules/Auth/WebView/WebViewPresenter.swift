//
//  WebViewPresenter.swift
//  DAL_Provider
//
//  Created by Mabdu on 05/05/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class WebViewPresenter: BasePresenter<WebViewViewContract> {
}
// MARK: - ...  Presenter Contract
extension WebViewPresenter: WebViewPresenterContract {
    func terms() {
        NetworkManager.instance.request(.terms, type: .get, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetch(for: model?.data ?? "")
                case .failure:
                    break
            }
        }
    }
}
