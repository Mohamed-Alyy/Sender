//
//  CardsListContract.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol CardsListPresenterContract: PresenterProtocol {
    func fetchCards()
    func deleteCards(for cardId: Int?)
    func setCardAsDefult(for cardId: Int?)
}
// MARK: - ...  View Contract
protocol CardsListContract: PresentingViewProtocol {
    func didFetchCards(for list: [CardsListModel.Datum]?)
}
// MARK: - ...  Router Contract
protocol CardsListRouterContract: Router, RouterProtocol {
    func dismiss()
    func didCreate()
    func didCompleteOrder(for address: Int?)
}
  
protocol CardsListDelegate: AnyObject {
    func addresses(_ delegate: CardsListDelegate?, didCreate create: Bool)
    func addresses(_ delegate: CardsListDelegate?, for address: CardsListModel.Datum?)
    func addresses(_ delegate: CardsListDelegate?, for address: Int?)
}

extension CardsListDelegate {
    func cards(_ delegate: CardsListDelegate?, for address: CardsListModel.Datum?) { }
}
