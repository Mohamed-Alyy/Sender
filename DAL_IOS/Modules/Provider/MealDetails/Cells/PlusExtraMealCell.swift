//
//  PlusExtraMealCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol PlusExtraMealDelegate: class {
    func plusExtraMeal(didPlus cell: PlusExtraMealCell)
}
class PlusExtraMealCell: UITableViewCell, CellProtocol {
    weak var delegate: PlusExtraMealDelegate?
    func setup() {
        
    }
    @IBAction func plus(_ sender: Any) {
        delegate?.plusExtraMeal(didPlus: self)
    }
}
