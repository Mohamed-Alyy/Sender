//
//  ProviderMealsRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ProviderMealsRouter: Router {
    typealias PresentingView = ProviderMealsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ProviderMealsRouter: ProviderMealsRouterContract {
    func filter() {
        guard let scene = R.storyboard.mealFilterStoryboard.mealFilterVC() else { return }
//        scene.delegate = view
//        scene.provider = view?.provider
        view?.pushPop(scene)
    }
    func meal(for meal: ProviderCategoriesMealsDatum?) {
        guard let scene = R.storyboard.mealDetailsStoryboard.mealDetailsVC() else { return }
        scene.meal = meal
        scene.mealID = meal?.id
        view?.push(scene)
    }
}
