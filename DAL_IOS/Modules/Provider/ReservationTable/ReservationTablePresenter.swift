//
//  ReservationTablePresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ReservationTablePresenter: BasePresenter<ReservationTableViewContract> {
}
// MARK: - ...  Presenter Contract
extension ReservationTablePresenter: ReservationTablePresenterContract {
    func fetchFilter() {
        NetworkManager.instance.request(.filterOptions, type: .get, FilterOptionModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchFilter(for: model?.data)
                case .failure:
                    break
            }
        }
    }
    func book(bookModel: ReservationTableModel?) {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        var paramters: [String: Any] = [:]
        paramters["qty"] = bookModel?.persons
        var ids: [Int] = []
        for id in bookModel?.services ?? [] {
            ids.append(id.id ?? 0)
        }
        paramters["feature_id"] = ids.toJson()
        paramters["prodvier_id"] = bookModel?.providerID
        paramters["reservation_time"] = bookModel?.hour
        paramters["reservation_date"] = bookModel?.date
        
        NetworkManager.instance.paramaters = paramters
        var method = ""
        if bookModel?.reservationID != nil {
            method = NetworkConfigration.EndPoint.endPoint(point: .reservation, paramters: [bookModel?.reservationID ?? 0])
        } else {
            method = NetworkConfigration.EndPoint.reservation.rawValue
        }
        NetworkManager.instance.request(method, type: .post, ReservationModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didBooked()
                case .failure:
                    break
            }
        }
    }
    
}

