//
//  ProfilePresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ProfilePresenter: BasePresenter<ProfileViewContract> {
}
// MARK: - ...  Presenter Contract
extension ProfilePresenter: ProfilePresenterContract {
    func fetch() {
        NetworkManager.instance.request(.profile, type: .get, UserRoot.self) { [weak self] (response) in
            self?.view?.stopLoading()
            switch response {
            case .success(let model):
                model?.save()
                self?.view?.didFetch()
            case .failure(_):
                break
            }
        }
    }
}
// MARK: - ...  Example of network response
extension ProfilePresenter {
    
}
