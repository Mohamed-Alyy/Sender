//
//  SearchFilterRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class SearchFilterRouter: Router {
    typealias PresentingView = SearchFilterVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SearchFilterRouter: SearchFilterRouterContract {

    func didFilter(paramters: [String : Any]? = nil) {
        view?.delegate?.searchFilter(view?.delegate, for: paramters ?? [:])
        view?.dismiss(animated: true, completion: nil)
    }
}
