//
//  Provider Ads.swift
//  DAL_IOS
//
//  Created by Zaghloul on 18/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderAdsVC: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    var data : [AdsResult]?
    override func viewDidLoad() {
        super.viewDidLoad()

       setUI()
    }

 
}
extension ProviderAdsVC {
    private func setUI(){
        registerCollectionViewNIB()
    }
    private func registerCollectionViewNIB(){
        collectionView.register(cell: ProviderAdsCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}
extension ProviderAdsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProviderAdsCell = collectionView.dequeue(indexPath: indexPath)
        let image = data?[indexPath.row]
        cell.adsImage.loadImage(urlString: image?.pic ?? "")
        cell.UIViewAction {
            Common().openUrl(text: image?.link)
        }
        return cell
    }
  
}

extension ProviderAdsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        //let height = collectionView.frame.height
        return CGSize(width: width , height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
