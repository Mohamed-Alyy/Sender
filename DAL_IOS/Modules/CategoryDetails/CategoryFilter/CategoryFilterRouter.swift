//
//  CategoryFilterRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class CategoryFilterRouter: Router {
    typealias PresentingView = CategoryFilterVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CategoryFilterRouter: CategoryFilterRouterContract {
    func didFilter(paramters: [String : Any]? = nil) {
        view?.delegate?.categoryFilter(view?.delegate, for: paramters ?? [:])
        view?.dismiss(animated: true, completion: nil)
    }
    
}
