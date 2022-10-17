//
//  FilterTableCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol FilterTableCellDelegate: class {
    func filterTableCell(didSelect cell: FilterTableCell)
    func filterTableCell(didDeselect cell: FilterTableCell)
}
class FilterTableCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var radioBtn: RadioButton!
    
    weak var delegate: FilterTableCellDelegate?
    
    func setup() {
        guard let model = model as? FilterModel else { return }
        if model.checked == true {
            radioBtn.select()
        } else {
            radioBtn.deselect()
        }
        if model is FilterOptionModel.Distance {
            titleLbl.text = "\(model.name ?? "") \("K.M".localized)"
        } else {
            titleLbl.text = model.name
        }
        radioBtn.onSelect { [weak self] in
            guard let self = self else { return }
            self.delegate?.filterTableCell(didSelect: self)
        }
        radioBtn.onDeselect { [weak self] in
            guard let self = self else { return }
            self.delegate?.filterTableCell(didDeselect: self)
        }
    }
}
