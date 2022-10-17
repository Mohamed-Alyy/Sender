//
//  ProviderPackagesVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 12/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderPackagesVC: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

}
extension ProviderPackagesVC {
    
    private func setUI(){
        registerCollectionViewNIB()
    }
    
    //MARK: - Register  CollectionView Cell
    private func registerCollectionViewNIB(){
        collectionView.register(cell: ProviderSenderPackagesCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
    }
}

//MARK: - UICollectionView Data Source
extension ProviderPackagesVC: UICollectionViewDataSource ,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProviderSenderPackagesCell = collectionView.dequeue(indexPath: indexPath)
        return cell
        
    }
}

//MARK: - UICollectionView Delegate, Flow Layout
extension ProviderPackagesVC: UICollectionViewDelegateFlowLayout {
    
    //MARK: - change size For Item Dependence on CollectionView type
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width 
            return CGSize(width: width  , height: 160)
        }
}

