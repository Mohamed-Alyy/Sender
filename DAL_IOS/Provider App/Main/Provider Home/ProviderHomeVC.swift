//
//  ProviderHomeVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 11/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderHomeVC: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
 
}

extension ProviderHomeVC {
    
    private func setUI(){
        registerCollectionViewNIB()
    }
    
    //MARK: - Register  CollectionView Cell
    private func registerCollectionViewNIB(){
        collectionView.register(cell: ProviderAdsCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
    }
}

//MARK: - UICollectionView Data Source
extension ProviderHomeVC: UICollectionViewDataSource ,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProviderAdsCell = collectionView.dequeue(indexPath: indexPath) 
        return cell
        
    }
}

//MARK: - UICollectionView Delegate, Flow Layout
extension ProviderHomeVC: UICollectionViewDelegateFlowLayout {
    
    //MARK: - change size For Item Dependence on CollectionView type
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            return CGSize(width: width - 40 , height: height)
        }
}

