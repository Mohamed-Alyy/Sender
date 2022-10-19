//
//  ProviderFilterOrdersTableViewCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 19/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

import UIKit

class ProviderFilterOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBorderOutlet: UIView!
    @IBOutlet weak var viewCircalOutlet: UIView!
    @IBOutlet weak var titleLableOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setCell(title: String) {
        titleLableOutlet.text = title
    }
    
    func setViewLayer() {
        viewBorderOutlet.borderColor = UIColor(red: 1, green: 0.4784313725, blue: 0.07450980392, alpha: 1)
        viewCircalOutlet.backgruondGradient()
    }
    
    func reSetViewLayer() {
        viewBorderOutlet.borderColor = UIColor(red: 0.7450980392, green: 0.7450980392, blue: 0.8196078431, alpha: 1)
        deleteLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        deleteLayer()
    }
    
    func deleteLayer() {
        viewCircalOutlet.layer.sublayers?.forEach({ layer in
            if Int(layer.zPosition) == ((viewCircalOutlet.layer.sublayers?.count)! - 1) {
                layer.removeFromSuperlayer()
            }
        })
    }
}

