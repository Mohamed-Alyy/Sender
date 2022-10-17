//
//  MakeOrderDoneContract.swift
//  DAL_IOS
//
//  Created by Mabdu on 24/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol MakeOrderDonePresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol MakeOrderDoneViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol MakeOrderDoneRouterContract: Router, RouterProtocol {
    func didDone(go orders: Bool?)
}

protocol OrderDoneDelegate: class {
    func orderDone(_ delegate: OrderDoneDelegate?)
}
