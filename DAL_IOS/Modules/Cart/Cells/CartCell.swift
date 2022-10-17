//
//  CartCell.swift
//  DAL_IOS
//
//  Created by rh.com.sa on 31/01/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol CartQuantityViewDelegateProtocol: AnyObject {
    func didTappedMinus(_ sender: UIButton)
    func didTappedPlus(_ sender: UIButton)
    func didTappedEdit(_ sender: UIButton)
    func didTappedDelete(_ cartModel: CartModel.Cart)
    
}

class CartCell: UITableViewCell, CellProtocol {
    class func instanceFromNib() -> CartCell {
        return UINib(nibName: "CartCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CartCell
    }
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    weak var cartDelegate: CartQuantityViewDelegateProtocol?
    var cartModel: CartModel.Cart?
    
    func setup() {
        guard let model = model as? CartModel.Cart else { return }
        cartModel = model
        imageCell.setImage(url: model.product?.image)
        titleLbl.text = model.product?.name
        priceLbl.text = model.product?.price ?? "0"
        countLbl.text = "\(model.quantity ?? 0)"
    }
    
    @IBAction func didTappedMinus(_ sender: UIButton){
        guard let count = Int(countLbl.text ?? "1") ,count != 1 else {return}
        cartDelegate?.didTappedMinus(sender)
    }
    
    @IBAction func didTappedPlus(_ sender: UIButton){
        cartDelegate?.didTappedPlus(sender)
    }
    
    
    @IBAction func didTappedEdit(_ sender: UIButton){
        cartDelegate?.didTappedEdit(sender)
    }
    
    @IBAction func didTappedDelete(_ sender: UIButton){
        guard let cartModel = cartModel else {
            return
        } 
        cartDelegate?.didTappedDelete(cartModel)
    }
}
