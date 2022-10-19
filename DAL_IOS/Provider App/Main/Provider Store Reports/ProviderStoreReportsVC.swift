//
//  ProviderStoreReportsVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 12/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderStoreReportsVC: UIViewController {

    @IBOutlet weak var reportsDetailsCollection: UICollectionView!
    @IBOutlet weak var mostAreasTableView: UITableView!
    @IBOutlet weak var bestItemsTableView: UITableView!
    @IBOutlet weak var reportsView: UIView!
    @IBOutlet weak var areasView: UIView!
    @IBOutlet weak var itemsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reportsView.shadow(opacity: 0.5, radius: 10, offset: CGSize(width: -1,height: 6), masks: false)
        areasView.shadow(opacity: 0.5, radius: 10, offset: CGSize(width: 0,height: 6), masks: false)
        itemsView.shadow(opacity: 0.5, radius: 10, offset: CGSize(width: 0,height: 6), masks: false)
    }

    
    private func setupUI() {
        self.title = "Store Reports".localized
        mostAreasTableView.register(cell: MostAreasCell.self)
        bestItemsTableView.register(cell: BestItemsCell.self)
        reportsDetailsCollection.register(cell: ReportsDetailsCell.self)
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named: "filter"), style:.plain, target: self, action: #selector(filterResults))
    }
    
    @objc func filterResults() {
        let vc = FilterResultsVC(nibName: "FilterResultsVC", bundle: nil)
        present(vc, animated: true)
    }
}


//MARK: - UICollectionView Delegate, DataSource
extension ProviderStoreReportsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReportsDetailsCell = collectionView.dequeue(indexPath: indexPath)
        return cell
    }
}


//MARK: - UICollectionView Delegate, Flow Layout
extension ProviderStoreReportsVC: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width - 10
            return CGSize(width: width/2  , height: 137)
        }
}


//MARK: - UITableView Delegate, DataSource
extension ProviderStoreReportsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case mostAreasTableView:
            return 5
        case bestItemsTableView:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case mostAreasTableView:
            let cell: MostAreasCell = tableView.dequeue(indexPath: indexPath)
            return cell
        case bestItemsTableView:
            let cell: BestItemsCell = tableView.dequeue(indexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case mostAreasTableView:
            return 50
        case bestItemsTableView:
            return 70
        default:
            return 0
        }
    }
}

