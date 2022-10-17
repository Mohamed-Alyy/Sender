//
//  PresenterProtocol.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Protocol
// All Presenters must implement this protocol
protocol PresenterProtocol {
    // Generic Type for any view
    associatedtype PresentingView
    var view: PresentingView? { get set }
    // methods for pagination
    func paginator(respnod: [Any]?)
    func canPaginate() -> Bool
    func resetPaginator()

}
// MARK: - ...  Implement pagination functions
extension PresenterProtocol {
    // MARK: - ...  check array size
    func paginator(respnod: [Any]?) {
        NetworkManager.instance.checkPaginator(respond: respnod)
    }
    // MARK: - ...  Check make another call for pagination
    func canPaginate() -> Bool {
        if !NetworkManager.instance.isHttpRequestRun && !NetworkManager.instance.paginatorStop {
            NetworkManager.instance.incresePaginate()
            return true
        } else {
            return false
        }
    }
    // MARK: - ...  Reset pagination Data
    func resetPaginator() {
        NetworkManager.instance.resetPaginate()
    }
}
