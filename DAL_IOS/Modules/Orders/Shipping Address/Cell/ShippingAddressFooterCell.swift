//
//  ShippingAddressFooterCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit 

class ShippingAddressFooterCell: UITableViewCell {

    class func instanceFromNib() -> ShippingAddressFooterCell {
        return UINib(nibName: "ShippingAddressFooterCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ShippingAddressFooterCell
    }
    
    weak var delegate: ShippingAddressCellProtocol?
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction
    func didTappedAddAnotherAddress(_ sender: UIButton){
        delegate?.addAnotherAddress()
    }
    
}
