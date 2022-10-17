//
//  CardsListVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

// MARK: - ...  ViewController - Vars
class CardsListVC: BaseController {
    @IBOutlet weak var cardsTbl: UITableView!
//    @IBOutlet weak var completeBtn: GradientButton!
    var presenter: CardsListPresenter?
    var router: CardsListRouter?
    weak var delegate: CardsListDelegate?
    var cards: [CardsListModel.Datum] = []
    var selectedCard: Int = 0
    var fromProfile: Bool = false
    
}

// MARK: - ...  LifeCycle
extension CardsListVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension CardsListVC {
    func setup() {
        registerTableView()
        startLoading()
        presenter?.fetchCards()
    }
    
    func reload() {
        cardsTbl.reloadData()
    }
     
}
extension CardsListVC {
    override func backBtn(_ sender: Any) {
        router?.dismiss()
    }
    @IBAction func createCard(_ sender: Any) {
        router?.didCreate()
    }
    @IBAction func completeOrder(_ sender: Any) {
        if let address = cards[safe: selectedCard]?.id {
            router?.didCompleteOrder(for: address)
        }
    }
}
// MARK: - ...  View Contract
extension CardsListVC: CardsListContract {
    func didFetchCards(for list: [CardsListModel.Datum]?){
        stopLoading()
        cards.removeAll()
        cards.append(contentsOf: list ?? [])
        reload()
    }
    
    private func registerTableView(){
        cardsTbl.register(cell: CardsListCell.self)
        cardsTbl.dataSource = self
        cardsTbl.delegate = self
        cardsTbl.tableFooterView = UIView()
    }
}

extension CardsListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CardsListCell = tableView.dequeue(indexPath: indexPath) 
        cell.indexPath = indexPath
        cell.delegate = self
        cell.model = cards[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router?.didEdit(for: self.cards[indexPath.row])
    }
}


extension CardsListVC: AddressTableCellProtocol {
    func didTappedDelete(_ row: Int) {
        self.presenter?.deleteCards(for: self.cards[row].id ?? 0)
        self.cards.remove(at: row)
        self.reload()
    }
    
    func didTappedMakeAsDefult(_ row: Int) {
        self.presenter?.setCardAsDefult(for: self.cards[row].id ?? 0)
    }
}
