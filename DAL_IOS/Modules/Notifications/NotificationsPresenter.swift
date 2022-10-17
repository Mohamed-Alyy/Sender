//
//  NotificationsPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class NotificationsPresenter: BasePresenter<NotificationsViewContract> {
}
// MARK: - ...  Presenter Contract
extension NotificationsPresenter: NotificationsPresenterContract {
    func fetchNotifications() {
        NetworkManager.instance.request(.notifications, type: .get, NotificationsModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetch(for: model?.data ?? [])
                case .failure:
                    self?.view?.stopLoading()

            }
        }
    }
}

