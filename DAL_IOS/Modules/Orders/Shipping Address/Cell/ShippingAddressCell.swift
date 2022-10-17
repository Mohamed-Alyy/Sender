//
//  ShippingAddressCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

protocol ShippingAddressCellProtocol: AnyObject {
    func didSelectedAddress(_ row: Int)
    func didTappedChoiceOfDelivery(_ row: Int)
    func addAnotherAddress()
}


class ShippingAddressCell: UITableViewCell,CellProtocol {

    @IBOutlet weak var addressNameLb: UILabel!
    @IBOutlet weak var addressCityLb: UILabel!
    @IBOutlet weak var addressDetailsLb: UILabel!
    @IBOutlet weak var choiceOfDeliveryButton: UIButton!
    @IBOutlet weak var choiceButton: UIButton!
    weak var delegate: ShippingAddressCellProtocol?
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    
    func setup(){
        guard let model = model as? AddressesModel.Datum else { return }
        addressNameLb.text = model.type
        addressCityLb.text = model.addressCity
        addressDetailsLb.text = model.datumDescription
        choiceOfDeliveryButton.isHidden = !model.isSelected
        let image = !model.isSelected ? UIImage(named: "radio") : UIImage(named: "radio-button-2")
        choiceButton.setImage(image, for: .normal)
    }
    
    
    @IBAction
    func didSelectedAddress(_ sender: UIButton){
        delegate?.didSelectedAddress(self.indexPath.row)
    }
    
    @IBAction
    func didTappedChoiceOfDelivery(_ sender: UIButton){
        delegate?.didTappedChoiceOfDelivery(self.indexPath.row)
    }
    
}
