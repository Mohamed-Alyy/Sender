//
//  SearchResultContainerRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class SearchResultContainerRouter: Router {
    typealias PresentingView = SearchResultContainerVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SearchResultContainerRouter: SearchResultContainerRouterContract {
    
}
