//
//  NewSearchContainerRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class NewSearchContainerRouter: Router {
    typealias PresentingView = NewSearchContainerVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension NewSearchContainerRouter: NewSearchContainerRouterContract {
    
}
