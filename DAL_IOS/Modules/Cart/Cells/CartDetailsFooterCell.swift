//
//  CartDetailsFooterCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class CartDetailsFooterCell: UITableViewCell,CellProtocol {
   
    class func instanceFromNib() -> CartDetailsFooterCell {
        return UINib(nibName: "CartDetailsFooterCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CartDetailsFooterCell
    }

    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
