//
//  ExArray.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 03/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

extension Array {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}

