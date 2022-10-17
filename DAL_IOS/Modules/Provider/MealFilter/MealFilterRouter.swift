//
//  MealFilterRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class MealFilterRouter: Router {
    typealias PresentingView = MealFilterVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MealFilterRouter: MealFilterRouterContract {
    func didFilter() {
        view?.delegate?.mealFilter(for: view?.subCategory, by: view?.sort, minPrice: view?.minPrice, maxPrice: view?.maxPrice)
        view?.dismiss(animated: true, completion: nil)
    }
}
