//
//  WalletVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 13/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class WalletVC: BaseController {

    //MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var walletBalanceLabel: UILabel!
    var walletModel:[WalletDatum]?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        registerTableView()
        fetchWallet()
    }
     

    private func registerTableView(){
        tableView.register(cell: FinancialTransactionsCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func fetchWallet() {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        NetworkManager.instance.request(.wallet, type: .get, WalletModel.self) { [weak self] (response) in
            guard let self = self else {return}
            defer { self.stopLoading() }
            switch response {
                case .success(let model):
                self.walletModel = model?.data
                self.walletBalanceLabel.text = "\(model?.wallet_balance ?? 0)"
                self.tableView.reloadData()
                case .failure:
                    break
            }
        }
    }
    
    @IBAction
    func didTappedWithdrawWalletBalance(_ sender: UIButton){
        let view = WithdrawWalletBalanceVC.loadFromNib()
        push(view)
    }
    
}

// MARK: - UITableView Data Source
extension WalletVC: UITableViewDataSource, UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return walletModel?.count ?? 0
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell: FinancialTransactionsCell = tableView.dequeue(indexPath: indexPath)
       let model = walletModel?.getElement(at: indexPath.row)
       cell.walletIconImage.image = model?.typeKey == "gift" ? UIImage(named: "gift") : UIImage(named: "returnWallet")
       cell.creditTypeLabel.text = model?.type
       cell.creditAmountLabel.text = "\(model?.amount ?? 0)"
       cell.dateLabel.text = model?.createAt
       return cell
   }
    
}
