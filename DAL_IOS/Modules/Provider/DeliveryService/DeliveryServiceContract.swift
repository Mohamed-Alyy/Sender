//
//  DeliveryServiceContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol DeliveryServicePresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol DeliveryServiceViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol DeliveryServiceRouterContract: Router, RouterProtocol {
    func confirm(ok: Bool?)
}

protocol DeliveryServiceDelegate: class {
    func deliveryService(_ delegate: DeliveryServiceDelegate?, for provider: Provider?)
}
