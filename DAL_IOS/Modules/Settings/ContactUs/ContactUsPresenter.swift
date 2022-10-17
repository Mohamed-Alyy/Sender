//
//  ContactUsPresenter.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ContactUsPresenter: BasePresenter<ContactUsViewContract> {
}
// MARK: - ...  Presenter Contract
extension ContactUsPresenter: ContactUsPresenterContract {
    func contact(contact: ContactUsModel?) {
        NetworkManager.instance.paramaters["sender_email"] = contact?.email
        NetworkManager.instance.paramaters["message"] = contact?.message
        NetworkManager.instance.paramaters["sender_name"] = contact?.name
        NetworkManager.instance.paramaters["address"] = contact?.address
        NetworkManager.instance.paramaters["whatsapp"] = contact?.whatsapp
        NetworkManager.instance.paramaters["sender_mobile"] = contact?.whatsapp
        
        NetworkManager.instance.request(.contact, type: .post, ContactResponseModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didSend(message: model?.message)
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
}
