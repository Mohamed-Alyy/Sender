//
//  LangIntroRouter.swift
//  DAL_Provider
//
//  Created by Mabdu on 03/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class LangIntroRouter: Router {
    typealias PresentingView = LangIntroVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension LangIntroRouter: LangIntroRouterContract {
    
}
