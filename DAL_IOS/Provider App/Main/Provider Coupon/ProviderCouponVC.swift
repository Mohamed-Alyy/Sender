//
//  ProviderCouponVC.swift
//  DAL_IOS
//
//  Created by Ahmed on 18/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit
import Kingfisher

class ProviderCouponVC: UIViewController {
    
    @IBOutlet var AddBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var SearchView: UIView!
    @IBOutlet var NavBarView: UIView!
    @IBOutlet var searchBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var navBtn: UIButton!
    @IBOutlet var cancelSearchBtn: UIButton!
    @IBOutlet var SearchBar: UISearchBar!
    var num = ["1","2","3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchView.isHidden = true
        self.SearchView.layer.cornerRadius = 10
        SearchView.layer.shadowColor = UIColor.black.cgColor
        SearchView.layer.shadowOpacity = 0.5
        SearchView.layer.shadowOffset = .zero
        SearchView.layer.shadowRadius = 8
        
        SearchView.layer.shadowPath = UIBezierPath(rect: SearchView.bounds).cgPath
        SearchView.layer.shouldRasterize = true
        SearchView.layer.rasterizationScale = UIScreen.main.scale
        titleLbl.text =  NSLocalizedString("Manage discount coupons", comment: "")
        
        SearchBar.placeholder = NSLocalizedString("PlaceHolder", comment: "")
        
        AddBtn.cornerRadius = AddBtn.frame.height/2
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CouponsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // UIColor(red: 0.96, green: 0.52, blue: 0.12, alpha: 1.00)
     
    }
   
   
    //back button
    @IBAction func navBtn(_ sender: Any) {
   
    }
    
    //delete
    @IBAction func deleteBtnAction(_ sender: Any) {
    }
    
    //add
    @IBAction func AddActionbtn(_ sender: Any) {
        
        let vc = EditAddVC()
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
    }
    //show search view
    @IBAction func searchBtnAction(_ sender: Any) {
        
        SearchView.isHidden = false
        
    }
    
    // hide search
    @IBAction func CancelSearchBtnAction(_ sender: Any) {
        SearchView.isHidden = true
    }
    // hide search
    @IBAction func CancelSearchBackIcon(_ sender: Any) {
        SearchView.isHidden = true
    }
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
extension ProviderCouponVC : CouponProtocol {
    func goToEdit() {
        let vc = EditAddVC()
        vc.modalPresentationStyle = .formSheet
        vc.didComeFromEdit = true
        self.present(vc, animated: true)
    }
    
    
}



extension ProviderCouponVC : UITableViewDelegate , UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num.count
  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CouponsTableViewCell{
             
            cell.delegate = self
            cell.cellView.layer.cornerRadius = 8
            cell.cellView.layer.shadowColor = UIColor.black.cgColor
            cell.cellView.layer.shadowOpacity = 0.1
            cell.cellView.layer.shadowOffset = .zero
            cell.cellView.layer.shadowRadius = 8
            
            cell.cellView.layer.shadowPath = UIBezierPath(rect: cell.cellView.bounds).cgPath
            cell.cellView.layer.shouldRasterize = true
            cell.cellView.layer.rasterizationScale = UIScreen.main.scale
            cell.CouponIDtitle.text = NSLocalizedString("Coupon ID" , comment: "")
            cell.CouponIDdb.text = "Fs546135464"
            cell.TheCouponLbl.text = "ALAA 15"
            cell.couponDate.text = "25 \(NSLocalizedString("march", comment: "")) 2022"
            cell.DiscountLbl.text = "20% \(NSLocalizedString("value",comment: ""))"
            
            cell.GreenView.layer.cornerRadius = 10
        
            cell.usageTimeTitle.text = NSLocalizedString("usage times", comment: "")
            cell.usageTimeNum.text = "34"
            cell.OrangeView.layer.cornerRadius = 10
            cell.leftTimesLbl.text = NSLocalizedString( "left times", comment: "")
            cell.leftTimesNum.text = "55"
            cell.switchLbl.text = NSLocalizedString("switch", comment: "")
            cell.EditBtn.setTitle(NSLocalizedString("edit button", comment: ""), for: .normal)
            cell.OrangeView.backgroundColor = KFCrossPlatformColor(hex:"#F6851F24" )
 
            cell.GreenView.backgroundColor = KFCrossPlatformColor(hex:"#3ECBC60F" )
            
            return cell
        }
        
        return UITableViewCell()
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
        
    }
    
}
