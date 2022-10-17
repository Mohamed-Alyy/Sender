//
//  ContactUsContract.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ContactUsPresenterContract: PresenterProtocol {
    func contact(contact: ContactUsModel?)
}
// MARK: - ...  View Contract
protocol ContactUsViewContract: PresentingViewProtocol {
    func didSend(message: String?)
    func didError(error: String?)
    func didFetch(for setting: ContactInfo?)
}
// MARK: - ...  Router Contract
protocol ContactUsRouterContract: Router, RouterProtocol {
}
