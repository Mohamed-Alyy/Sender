//
//  CardsListPresenter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

class CardsListPresenter: BasePresenter<CardsListContract> {
}
// MARK: - ...  Presenter Contract
extension CardsListPresenter: CardsListPresenterContract {
    func fetchCards() {
        NetworkManager.instance.request(.myCards, type: .get, CardsListModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchCards(for: model?.data)
                case .failure:
                    break
            }
        }
    }
    func deleteCards(for cardId: Int?) {
        let method = NetworkConfigration.EndPoint.endPoint(point: .myCards, paramters: [cardId ?? 0])
        NetworkManager.instance.request(method, type: .delete, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success:
                    break
                case .failure:
                    break
            }
        }
    }
    
    
    func setCardAsDefult(for cardId: Int?) {
        view?.startLoading()
        let method = NetworkConfigration.EndPoint.endPoint(point: .myCards, paramters: [cardId ?? 0,"default"])
        NetworkManager.instance.request(method, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success:
                self?.fetchCards()
                case .failure:
                    break
            }
        }
    }
}

