//
//  MealExtrasRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class MealExtrasRouter: Router {
    typealias PresentingView = MealExtrasVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MealExtrasRouter: MealExtrasRouterContract {
    func didPlusExtras(didEdit: Bool? = nil) {
        if didEdit != nil {
            view?.delegate?.mealExtras(view?.delegate, for: view?.meal)
        }
        view?.dismiss(animated: true, completion: nil)
    }
}
