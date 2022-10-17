//
//  CardsListCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class CardsListCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var cardNumberLb: UILabel!
    @IBOutlet weak var holderNameLb: UILabel!
    @IBOutlet weak var expirationDateLb: UILabel!
    @IBOutlet weak var setAsDefultSwitch: UISwitch!
    @IBOutlet weak var cardView: UIView!
    
    var indexPath: IndexPath!
    weak var delegate: AddressTableCellProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.applyGradient(colours: [UIColor.black, UIColor.black.withAlphaComponent(0.7)])
    }
    
    func setup(){
        guard let model = model as? CardsListModel.Datum else { return }
        cardNumberLb.text = model.cardNumber
        holderNameLb.text = model.cardHolder
        expirationDateLb.text = "\(model.expirationMonth ?? 0)/\(model.expirationYear ?? 0)"
        setAsDefultSwitch.isOn = model.isDefault != 0
    }
    
    
    @IBAction
    func didTappedDelete(_ sender: UIButton){
        delegate.didTappedDelete(self.indexPath.row)
    }
    
    @IBAction func didTappedSetAsDefultSwitch(_ sender: UISwitch) {
        delegate.didTappedMakeAsDefult(self.indexPath.row)
    }
}
