//
//  CreateCardContract.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
// MARK: - ...  Presenter Contract
protocol CreateCardPresenterContract: PresenterProtocol {
    func create()
}
// MARK: - ...  View Contract
protocol CreateCardViewContract: PresentingViewProtocol {
    func didCreate()
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol CreateCardRouterContract: Router, RouterProtocol {
    func back()
    func didCreate()
}

protocol CreateCardDelegate: AnyObject {
    func createCard(_ delegate: CreateCardDelegate?, didCreate create: Bool)
}
