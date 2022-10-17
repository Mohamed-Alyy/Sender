//
//  ResturantTableCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit
import Cosmos

protocol FavoriteCellDelegate: AnyObject {
    func favoriteCell(for cell: CellProtocol)
}
class ResturantTableCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var distanceBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var onlineOfflineProviderImage: UIImageView!
    
    weak var delegate: FavoriteCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup() {
        guard let model = model as? ProvidersResult else { return }
        imageCell.setImage(url: model.avatar)
        titleLbl.text = model.name
        rateView.rating = model.rating?.double ?? 0
        categoryLbl.text = model.category?.title
        distanceBtn.setTitle(model.distance, for: .normal)
         

        let isOpened = model.isOnline == 1 
        onlineOfflineProviderImage.image = isOpened ? UIImage(named: "unRedDot")! : UIImage(named: "Offline")!
    }
    @IBAction func favorite(_ sender: Any) {
        guard var model = model as? ProvidersResult else { return }
        model.like()
        delegate?.favoriteCell(for: self)
    }
}
