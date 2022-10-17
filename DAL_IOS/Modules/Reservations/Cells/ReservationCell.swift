//
//  OrderCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class ReservationCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var mealsLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    
    var tab: OrdersVC.Tab = .new
    func setup() {
        guard let model = model as? ReservationsModel.Datum? else { return }
        userImage.setImage(url: model?.providerImg)
        usernameLbl.text = model?.providerName
        let dateDay = DateHelper().date(date: model?.reservationDate, format: "d MMM", oldFormat: "yyyy-MM-dd")
        let dateHour = DateHelper().date(date: model?.reservationTime, format: "h:mm a", oldFormat: "HH:mm:ss")
        dateLbl.text = "\("day".localized) \(dateDay ?? "") , \("hour".localized) \(dateHour ?? "")"
        var services = ""
        var counter = 1
        for service in model?.features ?? [] {
            if counter == model?.features?.count {
                services += "\(service.name ?? "")"
            } else {
                services += "\(service.name ?? "") , "
            }
            counter += 1
        }
        mealsLbl.text = services
        //mealsLbl.text = model?.featureName
        
        if tab == .new {
            //newOrderView.isHidden = false
            //processingView.isHidden = true
            statusLbl.text = "\("count".localized) \(model?.qty ?? 0) \("persons".localized)"
            statusLbl.textColor = R.color.thirdTextColor()
        } else if tab == .processing {
            statusLbl.text = "\("count".localized) \(model?.qty ?? 0) \("persons".localized)"
            statusLbl.textColor = R.color.thirdTextColor()
            //timerBtn.setTitle("\("Remaining".localized) \(model?.remaining ?? "0") \("Minute".localized)", for: .normal)
        } else {
            statusLbl.text = model?.statusText
            if model?.status == 3 {
                statusLbl.textColor = R.color.textColorBlue()
            } else if model?.status == 4 {
                statusLbl.textColor = R.color.thirdColor()
            }
        }
    }
}
