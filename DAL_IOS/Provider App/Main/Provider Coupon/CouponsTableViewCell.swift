//
//  CouponsTableViewCell.swift
//  DAL_IOS
//
//  Created by Ahmed on 18/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

protocol CouponProtocol {
    func goToEdit()
}

class CouponsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var switchLbl: UILabel!
    @IBOutlet var EditBtn: UIButton!
    @IBOutlet var GreenView: UIView!
    @IBOutlet var leftTimesNum: UILabel!
    @IBOutlet var leftTimesLbl: UILabel!
    @IBOutlet var usageTimeNum: UILabel!
    @IBOutlet var usageTimeTitle: UILabel!
    @IBOutlet var OrangeView: UIView!
    
    @IBOutlet var DiscountLbl: UILabel!
    
    @IBOutlet var couponDate: UILabel!
    @IBOutlet var TheCouponLbl: UILabel!
    @IBOutlet var CouponIDdb: UILabel!
    @IBOutlet var CouponIDtitle: UILabel!
    @IBOutlet var cellView: UIView!
    
    var delegate : CouponProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func EsitBtnAction(_ sender: Any) {
        delegate?.goToEdit()
    }
}
