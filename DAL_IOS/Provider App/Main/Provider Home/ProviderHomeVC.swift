//
//  ProviderHomeVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 11/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderHomeVC: UIViewController {

    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var StoreReportsLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    var AdsArra = [adsDatum]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        GetAdsAPi()
    }
 
}

extension ProviderHomeVC {
    
    private func setUI(){
        registerCollectionViewNIB()
    }
    func GetAdsAPi(){
                NetworkManager.instance.request(.ads, type: .get, AdsApiModel.self) { [weak self] response in
                    switch response {
                        case .success(let model):
                        self!.collectionView.reloadData()
                        self?.AdsArra = (model?.data)!
                        case .failure:
                            break
                    }
                }
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
        return AdsArra.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProviderAdsCell = collectionView.dequeue(indexPath: indexPath)
        let image = AdsArra[indexPath.row]
        cell.adsImage.loadImage(urlString: image.pic)
        cell.UIViewAction {
            Common().openUrl(text: image.link)
        }
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

