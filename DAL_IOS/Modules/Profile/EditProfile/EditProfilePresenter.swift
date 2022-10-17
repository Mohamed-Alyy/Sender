//
//  EditProfilePresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

// MARK: - ...  Presenter
class EditProfilePresenter: BasePresenter<EditProfileViewContract> {
}
// MARK: - ...  Presenter Contract
extension EditProfilePresenter: EditProfilePresenterContract {
    func update() {
        guard let view = view as? EditProfileVC else { return }
        var paramters = view.paramters
        paramters["name"] = view.nameEditTxf.text
        paramters["email"] = view.emailEditTxf.text
        paramters["phone"] = view.phoneEditTxf.text
//        if view.passwordEditTxf.text?.count ?? 0 > 0 {
//            paramters["password"] = view.passwordEditTxf.text
//        }
//        paramters["age"] = view.ageEditTxf.text
//        paramters["gender"] = view.sexEditTxf.text
        
        view.startLoading()
        NetworkManager.instance.paramaters = paramters
        let method = NetworkConfigration.EndPoint.profile.rawValue
        NetworkManager.instance.uploadMultiImages(method, type: .post, file: ["avatar": view.avatarImage], UserRoot.self) { [weak self] (response) in
            self?.view?.stopLoading()
            switch response {
                case .success(let model):
                    model?.save()
                    self?.view?.didSuccess(withUser: model?.data?.id ?? 0)
                case .failure(let error):
                    self?.view?.didFail(error: error?.localizedDescription)
            }
        }
    }
    
    func deleteAccount() {
        self.view?.startLoading()
        NetworkManager.instance.request(.deleteAccount, type: .get, BaseModel<String>.self) { [weak self] (response) in
            guard let self = self else {return}
            defer {self.view?.stopLoading()}
            switch response {
                case .success(let model):
                self.view?.didDeleteSuccess(message: model?.message ?? "")
                case .failure(let error):
                self.view?.didFail(error: error?.localizedDescription)
            }
        }
    }
}
// MARK: - ...  Example of network response
extension EditProfilePresenter {

}
