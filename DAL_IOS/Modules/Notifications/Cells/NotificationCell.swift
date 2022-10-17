//
//  NotificationCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    func setup() {
        guard let model = model as? NotificationsModel.Datum else { return }
        titleLbl.text = "\(model.title ?? "") \n"
        descLbl.text = model.content
        dateLbl.text = "\(model.date ?? "") \(model.time ?? "")"
    }
    
}
