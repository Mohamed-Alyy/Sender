//
//  ReservationTableModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class ReservationTableModel: Codable {
    var id: Int?
    var providerID: Int?
    var date: String?
    var month: String?
    var day: String?
    var hour: String?
    var hourText: String?
    var minute: String?
    var services: [FilterOptionModel.Feature]?
    var persons: Int?
    var reservationID: Int?
    
}

// MARK: - ReservationModel
struct ReservationModel: Codable {
    let status: Bool?
    let msg: String?
    let data: DataClass?
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let id: Int?
        let providerName: String?
        let providerImg: String?
        let providerAddress: String?
        let status: Int?
        let date, time: String?

        enum CodingKeys: String, CodingKey {
            case id
            case providerName = "provider_name"
            case providerImg = "provider_img"
            case providerAddress = "provider_address"
            case status, date, time
        }
    }

}
