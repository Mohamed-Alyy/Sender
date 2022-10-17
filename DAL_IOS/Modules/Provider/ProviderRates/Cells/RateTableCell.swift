//
//  RateTableCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit
import Cosmos

class RateTableCell: UITableViewCell, CellProtocol {
    
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    func setup() {
        guard let model = model as? ProviderRatingsDatum else { return }
        imageCell.setImage(url: model.user?.avatar ?? "")
        commentLbl.text = model.comment
        usernameLbl.text = model.user?.name ?? ""
        let date = DateHelper().date(date: model.created_at, format: "MMM d, h:mm a")
        dateLbl.text = date
        rateView.rating = Double(model.rating ?? 0)
    }
    
}
