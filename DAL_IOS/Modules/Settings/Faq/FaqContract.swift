//
//  FaqContract.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol FaqPresenterContract: PresenterProtocol {
    func terms()
}
// MARK: - ...  View Contract
protocol FaqViewContract: PresentingViewProtocol {
    func didFetch(for terms: String)
}
// MARK: - ...  Router Contract
protocol FaqRouterContract: Router, RouterProtocol {
}
