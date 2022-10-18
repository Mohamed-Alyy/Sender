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
    
    var adsArra = [AdsResult]()
    private var carousalTimer: Timer?
    private var newOffsetX: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        GetAdsAPi()
    }
 
    @IBAction func showAllButton(_ sender: UIButton) {
        let vc = ProviderAdsVC.loadFromNib()
        vc.data = adsArra
        present(vc, animated: true)
    }
}

extension ProviderHomeVC {
    
    private func setUI(){
        registerCollectionViewNIB()
    }
    
    private func startTimer() {
        
         carousalTimer = Timer(fire: Date(), interval: 2, repeats: true) {[weak self] (timer) in
             guard let self = self else {return}
             let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
             let contentOffset = self.collectionView.contentOffset
             self.collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
         }
         RunLoop.current.add(carousalTimer!, forMode: .common)
     }
    
    func GetAdsAPi(){
        NetworkManager.instance.request(.ads, type: .get, AdsModel.self) { [weak self] response in
            guard let self = self else {return}
            switch response {
            case .success(let model):
                self.collectionView.reloadData()
                self.adsArra = model?.data ?? []
                self.startTimer()
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
        return adsArra.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProviderAdsCell = collectionView.dequeue(indexPath: indexPath)
        let image = adsArra[indexPath.row]
        cell.adsImage.loadImage(urlString: image.pic ?? "")
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

