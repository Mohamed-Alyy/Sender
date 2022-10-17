//
//  LoyaltyPointsVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 13/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class LoyaltyPointsVC: BaseController {

    //MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        registerTableView()
    }
     

    private func registerTableView(){
        tableView.register(cell: LoyaltyPointsCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction
    func didTappedWithdrawWalletBalance(_ sender: UIButton){
        let view = WithdrawWalletBalanceVC.loadFromNib()
        push(view)
    }
    
}

// MARK: - UITableView Data Source
extension LoyaltyPointsVC: UITableViewDataSource, UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell: LoyaltyPointsCell = tableView.dequeue(indexPath: indexPath)
       return cell
   }
    
}
