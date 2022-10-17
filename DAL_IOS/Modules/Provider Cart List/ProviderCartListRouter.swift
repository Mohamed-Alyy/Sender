//
//  ProviderCartListRouter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 15/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation


// MARK: - ...  Router
class ProviderCartListRouter: Router {
    typealias PresentingView = ProviderCartListVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ProviderCartListRouter: ProviderCartListRouterContract {
    func goToCart(providerId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
            guard let scene = R.storyboard.cartStoryboard.cartVC() else { return }
            scene.providerId = providerId
            self.view?.push(scene)
        }
    }
    
     
}
 
