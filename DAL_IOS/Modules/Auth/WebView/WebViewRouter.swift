//
//  WebViewRouter.swift
//  DAL_Provider
//
//  Created by Mabdu on 05/05/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class WebViewRouter: Router {
    typealias PresentingView = WebViewVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension WebViewRouter: WebViewRouterContract {
    
}
