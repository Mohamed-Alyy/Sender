//
//  QuantityModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/27/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Quantity View Model
protocol QuantityModel {
    var id: Int? { set get }
    var quantity: Int? { set get }
    var stock: Int? {set get}
}
