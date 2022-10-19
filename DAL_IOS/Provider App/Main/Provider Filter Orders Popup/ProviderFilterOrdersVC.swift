//
//  ProviderFilterOrdersVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 19/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

import UIKit

struct FilterOrders {
    var fromDate: String
    var paymentMethod: String
    var status: String
}
protocol FilterOrdersProtocol: AnyObject {
    func backFilterOrders(filterOrders: FilterOrders)
}

class ProviderFilterOrdersVC: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var nameScreenLableOutlet: UILabel!
    @IBOutlet weak var searchBtnOutlet: UIButton!
    @IBOutlet weak var cancelBtnOutlet: UIButton!
    @IBOutlet weak var categorizedByDateLableOutlet: UILabel!
    @IBOutlet weak var dateTextFieldOutlet: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var dataPickerOulet: UIDatePicker!
    
    //MARK: - Properts
    var paymentMethod = [String]()
    var status = [String]()
    
    var filterOrders: FilterOrders?
    weak var delegate: FilterOrdersProtocol?
    var dataPickerIsHiden = true
    
    //MARK: - Life Cycal
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setArrays()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// Fixed Update UI In Device Iphone 13  //  layoutSubviews and layoutIfNeeded  not work
        tableview.reloadData()
    }
    
    //MARK: - Action
    @IBAction func searchBtnAction(_ sender: UIButton) {
        delegate?.backFilterOrders(filterOrders: handelFilterOrdersToApi()) 
        debugPrint(handelFilterOrdersToApi().paymentMethod, handelFilterOrdersToApi().status, handelFilterOrdersToApi().fromDate)
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func showMoreBtnAction(_ sender: UIButton) {
        scrollTolastIndex()
    }
    
    @IBAction func showMoreBtnActionTemp(_ sender: UIButton) {
        scrollTolastIndex()
    }
    
    
    //MARK: - Method
    func setArrays() {
        paymentMethod = ["All", "Cash", "Visa", "Mada"]
        status = ["All", "New", "Preparation in Progress", "Ready"]
        
        filterOrders = FilterOrders(fromDate: "", paymentMethod: "All", status: "All")
    }
    
    func scrollTolastIndex() {
        let index = IndexPath(row: (status.count - 1), section: 1)
        tableview.scrollToRow(at: index, at: .none, animated: true)
    }
    
    
    @IBAction func btnShowDateTab(sender: UIButton) {
        /// If use toggle project Sender give error  ( Ambiguous use of 'toggle()' )
//        dataPickerIsHiden.toggle()
        
        dataPickerIsHiden = dataPickerIsHiden == true ? false : true
        dataPickerOulet.isHidden = dataPickerIsHiden
    }
    
    func handelFilterOrdersToApi() -> FilterOrders {
        let fromDate = filterOrders?.fromDate.lowercased() ?? ""
        let paymentMethod = filterOrders?.paymentMethod.lowercased() ?? ""
        var status: String {
            switch filterOrders?.status {
            case "New":
                return "new"
            case "Preparation in Progress":
                return "in_progress"
            case "Ready":
                return "finished"
            default :
                return ""
            }
        }
        
        let filterOrdersLowercased = FilterOrders(fromDate: fromDate, paymentMethod: paymentMethod, status: status)
        return filterOrdersLowercased
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


//MARK: - Set UI
extension ProviderFilterOrdersVC: UITableViewDelegate, UITableViewDataSource {
    
    // set Tableview
    func setTableview() {
        
        tableview.delegate = self
        tableview.dataSource = self
        
        let identfireCell = String(describing: ProviderFilterOrdersTableViewCell.self)
        tableview.register(UINib(nibName: identfireCell, bundle: nil), forCellReuseIdentifier: identfireCell)
        let identfireHeader = String(describing: ProviderHeaderTableviewFilterOrdersCell.self)
        tableview.register(UINib(nibName: identfireHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: identfireHeader)
        
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.bounces = false
    }
    
    // number Of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if section == 0 {
            return paymentMethod.count
        }
        return status.count
   }
    
    // cell For RowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identfireCell = String(describing: ProviderFilterOrdersTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identfireCell, for: indexPath) as! ProviderFilterOrdersTableViewCell
        
        if indexPath.section == 0 {
            if paymentMethod.getElement(at: indexPath.row) == filterOrders?.paymentMethod {
                cell.setViewLayer()
            } else {
                cell.reSetViewLayer()
            }
            cell.setCell(title: paymentMethod[indexPath.row])
            return cell
        }
        
        if status.getElement(at: indexPath.row) == filterOrders?.status {
            cell.setViewLayer()
        } else {
            cell.reSetViewLayer()
        }
        cell.setCell(title: status[indexPath.row])
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            filterOrders?.paymentMethod = paymentMethod.getElement(at: indexPath.row) ?? ""
        } else {
            filterOrders?.status = status.getElement(at: indexPath.row) ?? ""
        }
        tableview.reloadData()
   }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let heightTableView = tableView.frame.size.height
        let height = (heightTableView - 160) / 8
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let identfire = String(describing: ProviderHeaderTableviewFilterOrdersCell.self)
        let headerView =  tableView
            .dequeueReusableHeaderFooterView(withIdentifier: identfire) as! ProviderHeaderTableviewFilterOrdersCell
        let title = (section == 0) ? "Payment Method" : "State Order"
        
        headerView.setHeader(title: title)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
}

//MARK: - Date Picker
extension ProviderFilterOrdersVC {
    
    func setDatePicker() {

        dataPickerOulet.backgroundColor = .white
        dataPickerOulet.datePickerMode = .date
        dataPickerOulet.timeZone = NSTimeZone.local
        dataPickerOulet.minimumDate = Date()
        dataPickerOulet.addTarget(self, action: #selector(self.addDateToTextField), for: UIControl.Event.valueChanged)
        
        if #available(iOS 13, *) {
            dataPickerOulet.preferredDatePickerStyle = .wheels
        }
    }
    
    @objc func addDateToTextField(){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-mm-dd"
        let date = dateFormat.string(from: dataPickerOulet.date)
        
        dateTextFieldOutlet.text = date
        filterOrders?.fromDate = date
    }
    
}



//MARK: - Set UI
extension ProviderFilterOrdersVC {
    
    func setUI() {
        setDatePicker()
        setTableview()
        dateTextFieldOutlet.textAlignment =  Localizer.current == .arabic ? .right : .left
    }

    

}
