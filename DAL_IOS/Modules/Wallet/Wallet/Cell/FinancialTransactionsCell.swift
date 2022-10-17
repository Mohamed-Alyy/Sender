//
//  FinancialTransactionsCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 13/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class FinancialTransactionsCell: UITableViewCell {

    @IBOutlet weak var walletIconImage: UIImageView!
    @IBOutlet weak var creditTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var creditAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
