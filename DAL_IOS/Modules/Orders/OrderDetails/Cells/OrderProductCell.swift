//
//  OrderProductCell.swift
//  DAL_IOS
//
//  Created by Mabdu on 17/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit
import Cosmos

class OrderProductCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var extrasTbl: UITableView!
    @IBOutlet weak var extrasView: UIView!
    @IBOutlet weak var customerNoteView: UIView!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var noteTitleLbl: UILabel!
    @IBOutlet weak var containerRateView: UIView!
    
    var tab: OrdersVC.Tab = .new
    func theme(){
        extrasTbl.delegate = self
        extrasTbl.dataSource = self
        extrasTbl.reloadData()
    }
    func setup() {
        guard let model = model as? OrdersModel.Item else { return }
        imageCell.setImage(url: model.product?.image)
        titleLbl.text = "\(model.product?.name ?? "")"
        quantityLbl.text = "\(model.quantity ?? 0) x"
        descLbl.text = ""
        priceLbl.text = model.peicePrice ?? "0"
        extrasTbl.delegate = self
        extrasTbl.dataSource = self
        reloadHeight()
//        if model.notes?.isEmpty == true {
//            noteLbl.text = nil
//            noteTitleLbl.text = nil
//            customerNoteView.isHidden = true
//            if let constraint = noteTitleLbl.constraints.first(where: { $0.firstAttribute == .top }) {
//                constraint.constant = 0
//            }
//            if let constraint = noteLbl.constraints.first(where: { $0.firstAttribute == .bottom }) {
//                constraint.constant = 0
//            }
////            if let constraint = customerNoteView.constraints.first(where: { $0.firstAttribute == .height }) {
////                constraint.constant = 0
////            }
//        } else {
////            if let constraint = customerNoteView.constraints.first(where: { $0.firstAttribute == .height }) {
////                constraint.constant = 58
////            }
//            customerNoteView.isHidden = false
//            noteLbl.text = model.notes
//        }
        
//        if tab != .completed {
//            containerRateView.isHidden = true
//            return
//        }
    }
    
}
extension OrderProductCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = model as? OrdersModel.Item else { return 1}
        return model.additions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model as? OrdersModel.Item else { return UITableViewCell() }
        var cell = tableView.cell(type: ExtraMealCell.self, indexPath)
        cell.model = model.additions?[safe: indexPath.row]
        cell.setupExtraInOrder()
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    func reloadHeight() {
        guard let model = model as? OrdersModel.Item else { return }
        if let constraint = extrasView.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = 50
            constraint.constant += 55 * (model.additions?.count ?? 0).cgFloat
            if model.additions?.count == 0 {
                constraint.constant = 0
                extrasView.isHidden = true
            }
        }
        
    }
}
