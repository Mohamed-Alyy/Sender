//
//  FavoriteBuilderPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/21/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  Presenter
class FavoriteBuilderPresenter: BasePresenter<FavoriteBuilder> {

}
// MARK: - ...  Presenter Contract
extension FavoriteBuilderPresenter: FavoriteBuilderPresenterContract, PopupConfirmationViewContract {
    func startLoading() {
        
    }
    func stopLoading() {
        
    }
    func like() {
        if UserRoot.token() == nil {
            let scene = UIApplication.topViewController() as? BaseController
            PopupConfirmationVC.confirmationPOPUP(view: scene, title: "You must be logged in first!".localized, btns: [.agree, .skip]) {
                return
            } onAgreeClosure: {
                Router.instance.unAuthorized()
                return
            }
            return
        }
         
        let method = NetworkConfigration.EndPoint.endPoint(point: .favorites, paramters: [view?.id ?? 0,"toggle"])
        NetworkManager.instance.request(method, type: .post, BaseModel<Int>.self) { [weak self] (response) in
            switch response {
                case .success:
                    self?.view?.didLike()
                case .failure:
                    break
            }
        }
    }
}
