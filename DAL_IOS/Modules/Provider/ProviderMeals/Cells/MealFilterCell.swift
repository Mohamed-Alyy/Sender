//
//  MealFilterCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol MealFilterCellDelegate: class {
    func mealFilterCell(didRemove cell: MealFilterCell)
}
class MealFilterCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var titleLbl: UILabel!
    
    weak var delegate: MealFilterCellDelegate?
    func setup() {
        
    }
    @IBAction func remove(_ sender: Any) {
        delegate?.mealFilterCell(didRemove: self)
    }
}
