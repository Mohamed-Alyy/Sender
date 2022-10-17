//
//  FavoritesRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class FavoritesRouter: Router {
    typealias PresentingView = FavoritesVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension FavoritesRouter: FavoritesRouterContract {
    func provider(for provider: ProvidersResult?) {
        guard let scene = R.storyboard.providerDetailsStoryboard.providerDetailsVC() else { return }
        scene.provider = provider
        view?.push(scene)
    }
    
}
