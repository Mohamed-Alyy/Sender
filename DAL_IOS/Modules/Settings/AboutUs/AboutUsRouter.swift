//
//  AboutUsRouter.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class AboutUsRouter: Router {
    typealias PresentingView = AboutUsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension AboutUsRouter: AboutUsRouterContract {
    
}
