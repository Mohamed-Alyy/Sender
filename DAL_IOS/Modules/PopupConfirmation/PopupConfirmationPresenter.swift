//
//  PopupConfirmationPresenter.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/4/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class PopupConfirmationPresenter: BasePresenter<PopupConfirmationViewContract> {
}
// MARK: - ...  Presenter Contract
extension PopupConfirmationPresenter: PopupConfirmationPresenterContract {
}
// MARK: - ...  Example of network response
extension PopupConfirmationPresenter {
    func fetchResponse<T: PopupConfirmationModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
