//
//  CreateCardPresenter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class CreateCardPresenter: BasePresenter<CreateCardViewContract> {
}
// MARK: - ...  Presenter Contract
extension CreateCardPresenter: CreateCardPresenterContract {
     
    func create() {
        guard let view = view as? CreateCardVC else { return }
        if !view.validate(txfs: [view.cardNumberTxf, view.cardHolderNameTxf,view.expirationDateTxf,view.cvvTxf]) {
            return
        }
        view.startLoading()
        var paramaters: [String: Any] = [String: Any]()
        paramaters["card_number"] = view.cardNumberTxf.text
        paramaters["card_holder"] = view.cardHolderNameTxf.text
        paramaters["expiration_year"] = view.expirationDateTxf.text?[3 ... 6]
        paramaters["expiration_month"] = view.expirationDateTxf.text?[0 ... 1]
        paramaters["cvv"] = view.cvvTxf.text
        NetworkManager.instance.paramaters = paramaters
        NetworkManager.instance.request(.myCards, type: .post, BaseModel<String>.self) { [weak self] (response) in
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
        guard let view = view as? CreateCardVC else { return }
        if !view.validate(txfs: [view.cardNumberTxf, view.cardHolderNameTxf,view.expirationDateTxf,view.cvvTxf]) {
            return
        }
        view.startLoading()
        var paramaters: [String: Any] = [String: Any]()
        paramaters["card_number"] = view.cardNumberTxf.text
        paramaters["card_holder"] = view.cardHolderNameTxf.text
        paramaters["expiration_year"] = view.expiryDatePicker.year
        paramaters["expiration_month"] = view.expiryDatePicker.month
        paramaters["cvv"] = view.cvvTxf.text
        NetworkManager.instance.paramaters = paramaters
        let method = NetworkConfigration.EndPoint.endPoint(point: .myCards, paramters: [view.oldCard?.id ?? 0])
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

