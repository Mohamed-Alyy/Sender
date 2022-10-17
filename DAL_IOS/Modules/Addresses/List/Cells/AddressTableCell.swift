//
//  AddressTableCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol AddressTableCellProtocol: AnyObject {
    func didTappedDelete(_ row: Int)
    func didTappedMakeAsDefult(_ row: Int)
}

class AddressTableCell: UITableViewCell, CellProtocol {
    
    
    @IBOutlet weak var addressNameLb: UILabel!
    @IBOutlet weak var addressCityLb: UILabel!
    @IBOutlet weak var addressDetailsLb: UILabel!
    @IBOutlet weak var setAsDefultSwitch: UISwitch!
     
    weak var delegate: AddressTableCellProtocol!
    var indexPath: IndexPath!
    
    func setup(){
        guard let model = model as? AddressesModel.Datum else { return }
        addressNameLb.text = model.type
        addressCityLb.text = model.addressCity
        addressDetailsLb.text = model.datumDescription
        setAsDefultSwitch.isOn = model.isDefault != 0
    }
    
    
    @IBAction
    func didTappedDelete(_ sender: UIButton){
        delegate.didTappedDelete(self.indexPath.row)
    }
    
    @IBAction func didTappedSetAsDefultSwitch(_ sender: UISwitch) {
        delegate.didTappedMakeAsDefult(self.indexPath.row)
    }
}
