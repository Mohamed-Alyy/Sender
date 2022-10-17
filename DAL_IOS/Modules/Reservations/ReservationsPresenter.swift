//
//  ReservationsPresenter.swift
//  DAL_Provider
//
//  Created by Mabdu on 28/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ReservationsPresenter: BasePresenter<ReservationsViewContract> {
}
// MARK: - ...  Presenter Contract
extension ReservationsPresenter: ReservationsPresenterContract {
    func fetchReservations(tab: OrdersVC.Tab) {
        if tab == .new {
            NetworkManager.instance.paramaters["type"] = "new"
        } else if tab == .processing {
            NetworkManager.instance.paramaters["type"] = "current"
        } else {
            NetworkManager.instance.paramaters["type"] = "finished"
        }
        //new, processing, finished, canceled
        NetworkManager.instance.request(.reservations, type: .get, ReservationsModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetch(for: model?.data)
                case .failure:
                    self?.view?.stopLoading()

            }
        }
    }
    func filterReservations(filter: ReservationsFilterModel?) {
        NetworkManager.instance.paramaters["from"] = filter?.from
        NetworkManager.instance.paramaters["to"] = filter?.to
        NetworkManager.instance.paramaters["time"] = filter?.time?.rawValue
        NetworkManager.instance.paramaters["status"] = filter?.status
        NetworkManager.instance.paramaters["type"] = "reservation"
        //new, processing, finished, canceled
        NetworkManager.instance.request(.filterOrder, type: .post, ReservationsModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetch(for: model?.data)
                case .failure:
                    self?.view?.stopLoading()

            }
        }
    }
}
