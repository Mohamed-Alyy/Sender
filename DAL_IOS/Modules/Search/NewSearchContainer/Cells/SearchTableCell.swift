//
//  SearchTableCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol SearchTableCellDelegate: class {
    func searchTableCell(didDelete cell: SearchTableCell)
}
class SearchTableCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var titleLbl: UILabel!
    
    weak var delegate: SearchTableCellDelegate?
    func setup() {
        
    }
    
    @IBAction func remove(_ sender: Any) {
        delegate?.searchTableCell(didDelete: self)
    }
}
