//
//  DeliveryTypeContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/2/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol DeliveryTypePresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol DeliveryTypeViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol DeliveryTypeRouterContract: Router, RouterProtocol {
    func didDismiss()
    func delivery()
    func branch()
}

protocol DeliveryTypeDelegate: class {
    func deliveryType(_ delegate: DeliveryTypeDelegate?, branch: Bool?)
    func deliveryType(_ delegate: DeliveryTypeDelegate?, delivery: Bool?)
}
