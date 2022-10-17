//
//  FaqRouter.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class FaqRouter: Router {
    typealias PresentingView = FaqVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension FaqRouter: FaqRouterContract {
    
}
