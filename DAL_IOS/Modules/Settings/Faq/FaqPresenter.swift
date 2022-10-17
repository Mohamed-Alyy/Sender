//
//  FaqPresenter.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class FaqPresenter: BasePresenter<FaqViewContract> {
}
// MARK: - ...  Presenter Contract
extension FaqPresenter: FaqPresenterContract {
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
