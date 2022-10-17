//
//  ReservationsFilterModel.swift
//  DAL_IOS
//
//  Created by Mabdu on 16/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class ReservationsFilterModel {
    enum TimeType: String {
        case am
        case pm
    }
    var from: String?
    var to: String?
    var status: String?
    var type: String?
    var time: TimeType?
}
