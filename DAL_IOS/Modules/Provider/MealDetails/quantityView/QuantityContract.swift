//
//  QuantityContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/27/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Quantity View DataSource
protocol QuantityViewDataSource: class {
    // MARK: - ... Get item for each view
    func quantityView(_ view: QuantityView?) -> QuantityModel?
}
// MARK: - ...  Quantiy View delegate
protocol QuantityViewDelegate: class {
    // MARK: - ...  Did change item
    func quantityView(_ view: QuantityView?, didChange item: QuantityModel?)
}
