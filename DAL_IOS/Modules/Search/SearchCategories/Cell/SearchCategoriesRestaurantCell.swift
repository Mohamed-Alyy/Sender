//
//  SearchCategoriesRestaurantCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 19/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit
import Cosmos

class SearchCategoriesRestaurantCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var loyaltyPointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
        if model is ProvidersResult {
            guard let model = model as? ProvidersResult else { return }
            imageCell.setImage(url: model.avatar)
            titleLbl.text = model.name
            distanceLabel.text = model.distance
            rateView.rating = Double(model.rating ?? 0)
            loyaltyPointsLabel.text = "0" + " " + "Loyalty Points".localized
            categoryLbl.text = model.category?.title ?? ""
        }else {
            guard let model = model as? ProviderCartListDatum else { return }
            imageCell.setImage(url: model.provider?.avatar)
            titleLbl.text = model.provider?.name
            distanceLabel.text = model.provider?.distance
            rateView.rating = Double(model.provider?.rating ?? 0)
            loyaltyPointsLabel.text = "0" + " " + "Loyalty Points".localized
            categoryLbl.text = model.provider?.category?.title
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
