//
//  CoreViewModel.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation

// MARK: - ...  Base Presenter
class BasePresenter<T>: NSObject, PresenterProtocol {
    typealias PresentingView = T
    private var _view: PresentingView?
    var view: PresentingView? {
        set {
            _view = newValue
        } get {
            return _view
        }
    }
    // MARK: - ...  empty the refrence 
    deinit {
        view = nil
    }
}
