//
//  OrderCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol OrderCellDelegate: AnyObject {
    func orderCell(_ cell: OrderCell?, did reOrder: Bool?)
}
class OrderCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var extrasLbl: UILabel! 
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var tab: OrdersVC.Tab = .new
    weak var delegate: OrderCellDelegate?
    func setup() {
        guard let model = model as? OrdersModel.Datum? else { return }
        statusLbl.text = model?.status
        productImage.setImage(url: model?.items?.first?.product?.image)
        titleLbl.text = model?.provider?.name ?? ""
        idLbl.text = "\(model?.id ?? 0)"
        var extras = ""
        var counter = 1
        for extra in model?.items?.first?.additions ?? [] {
            if counter == model?.items?.first?.additions?.count {
                extras += "\(extra.name ?? ""), "
            } else {
                extras += "\(extra.name ?? "")"
            }
            counter += 1
        }
        extrasLbl.text = "\("extras".localized): \(extras)"
        priceLbl.text = model?.total ?? "0" // model?.total?.string
        dateLbl.text = "\("Order date".localized): \(model?.times?.createdAt ?? "")"
        
    }
    @IBAction func reOrder(_ sender: Any) {
        delegate?.orderCell(self, did: true)
    }
}
