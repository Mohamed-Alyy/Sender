//
//  OnBoardingContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol OnBoardingPresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol OnBoardingViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol OnBoardingRouterContract: Router, RouterProtocol {
    func startApplication()
}
