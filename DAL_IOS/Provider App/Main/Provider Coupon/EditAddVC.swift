//
//  EditAddVC.swift
//  DAL_IOS
//
//  Created by Ahmed on 19/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class EditAddVC: UIViewController {
  
    @IBOutlet var StateLbl: UILabel!
    @IBOutlet var couponState: UILabel!
    @IBOutlet var timesOfUsageTxt: UITextField!
    @IBOutlet var amountTxt: UITextField!
    @IBOutlet var dateViewFrom: UIView!
    @IBOutlet var couponDate: UILabel!
    @IBOutlet var fixdPriceLbl: UILabel!
    @IBOutlet var fixedPriceBtn: UIButton!
    @IBOutlet var percantageLbl: UILabel!
    @IBOutlet var percantageBtn: UIButton!
    @IBOutlet var typeOfDisLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var dateViewTo: UIView!
    @IBOutlet var discountCouponTxt: UITextField!
    
    @IBOutlet var saveBtn: UIButton!
    var didComeFromEdit = false
    var percentage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        localization()
        
        
        fixedPriceBtn.setImage( UIImage(systemName: "circle"), for: .normal)
        percantageBtn.setImage( UIImage(systemName: "circle"), for: .normal)
        dateViewFrom.borderWidth = 0.5
        dateViewTo.borderWidth = 0.5

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        saveBtn.applyGradient()
    }
    
    
    func localization (){
        
        if didComeFromEdit{
            
            titleLbl.text = NSLocalizedString("edit", comment: "")
            
        }else{
            titleLbl.text = NSLocalizedString("add" , comment: "")
            
        }
        
        
        
        couponState.text = NSLocalizedString("coupon state", comment: "")
        StateLbl.text = NSLocalizedString("switch", comment: "")
        
        discountCouponTxt.placeholder = NSLocalizedString("discoint code", comment: "")
        typeOfDisLbl.text = NSLocalizedString("type of discount", comment: "")
        percantageLbl.text = NSLocalizedString("percantage", comment: "")
        fixdPriceLbl.text = NSLocalizedString("fixed price", comment: "")
        
        couponDate.text = NSLocalizedString("coupon date", comment: "")
        timesOfUsageTxt.placeholder = NSLocalizedString("times of usage", comment: "")
        amountTxt.placeholder = NSLocalizedString("amount", comment: "")
        saveBtn.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        
       
        //        "edit" = "تعديل كود الخصم";
        //        "discoint code" = "كود الخصم" ;
        //        "type of discount" = "نوع الخصم" ;
        //        "percantage" = "نسبة" ;
        //        "fixed price" = "مبلغ ثابت" ;
        //        "amount" = "مقدار الخصم " ;
        //        "times of usage" = "عدد مرات الاسنخدام" ;
       // "times of usage" = "عدد مرات الاسنخدام" ;
      //  "coupon date" = "تاريخ صلاحية الكود";
    }
    
    
    @IBAction func saveBtnActio(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    
    
    @IBAction func fixdPriceActionBtn(_ sender: Any) {
        if percentage == false {
            fixedPriceBtn.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            percentage = true
        }else{
            fixedPriceBtn.setImage( UIImage(systemName: "circle"), for: .normal)
            percentage = false
        }
        
    }
    @IBAction func percantageBtnAction(_ sender: Any) {
        
        if percentage == false {
            percantageBtn.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            percentage = true
        }else{
            percantageBtn.setImage( UIImage(systemName: "circle"), for: .normal)
            percentage = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
