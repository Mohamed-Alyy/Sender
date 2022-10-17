//
//  WebViewContract.swift
//  DAL_Provider
//
//  Created by Mabdu on 05/05/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol WebViewPresenterContract: PresenterProtocol {
    func terms()
}
// MARK: - ...  View Contract
protocol WebViewViewContract: PresentingViewProtocol {
    func didFetch(for terms: String)
    
}
// MARK: - ...  Router Contract
protocol WebViewRouterContract: Router, RouterProtocol {
}
