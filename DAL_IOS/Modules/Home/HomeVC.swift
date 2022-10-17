//
//  HomeVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/29/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class HomeVC: BaseController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchTxf: UITextField!
    @IBOutlet weak var slidersCollection: UICollectionView!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var productsCollection: UICollectionView!
//    @IBOutlet weak var userImage: UIImageView!
    var presenter: HomePresenter?
    var router: HomeRouter?
    var categoriesResult: [CategoriesResult]?
    var adsRsult: [AdsResult]?
    var suggestedProducts: [ProviderCategoriesMealsDatum]?
    private var carousalTimer: Timer?
    private var newOffsetX: CGFloat = 0.0
}

// MARK: - ...  LifeCycle
extension HomeVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
    }
}
// MARK: - ...  Functions
extension HomeVC {
    func setup() {
        slidersCollection.delegate = self
        slidersCollection.dataSource = self
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        productsCollection.delegate = self
        productsCollection.dataSource = self
        scrollView.delegate = self
        presenter?.fetchHome()
        startTimer()
//        userImage.setImage(url: UserRoot.fetchUser()?.avatar)
    }
    func reload() {
        categoriesCollection.reloadData()
        productsCollection.reloadData()
        slidersCollection.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.slidersCollection.reloadData()
        }
        if let constraint = productsCollection.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = productsCollection.collectionViewLayout.collectionViewContentSize.height
        }
    }
    
    private func startTimer() {
         carousalTimer = Timer(fire: Date(), interval: 2, repeats: true) { (timer) in
             let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
             let contentOffset = self.slidersCollection.contentOffset
             self.slidersCollection.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
         }
         RunLoop.current.add(carousalTimer!, forMode: .common)
     }
}
// MARK: - ...  Actions
extension HomeVC {
    @IBAction func search(_ sender: Any) {
        router?.search(text: nil, for: nil)
    }
    
    @IBAction func didTappedCart(_ sender: Any) {
        router?.openProviderCart()
    }
}
// MARK: - ...  View Contract
extension HomeVC: HomeViewContract {
    func didFetchSuggestedProducts(model: [ProviderCategoriesMealsDatum]?) {
        suggestedProducts = model
        reload()
    }
    
    func didFetchAds(model: [AdsResult]?) {
        adsRsult = model
        reload()
    }
    
    func didFetchCategories(model: [CategoriesResult]?) {
  
        categoriesResult = model
        reload()
    }
    
    func didFetchUser() {
        self.router?.rateOrder()
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == slidersCollection {
            return CGSize(width: collectionView.width, height: collectionView.height)
        } else if collectionView == categoriesCollection {
            return CGSize(width: 175, height: 70)
        } else {
            return CGSize(width: collectionView.width/2 - 15, height: 225)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == slidersCollection {
            return adsRsult?.count ?? 0
        } else if collectionView == categoriesCollection {
            return categoriesResult?.count ?? 0
        } else {
            return suggestedProducts?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == slidersCollection {
            return sliderCell(for: indexPath)
        } else if collectionView == categoriesCollection {
            return categoryCell(for: indexPath)
        } else {
            return productCell(for: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollection {
            guard let category = categoriesResult?.getElement(at: indexPath.row) else {return}
            router?.search(text: nil, for: category)
        } else if collectionView == productsCollection {
            guard let mealId = suggestedProducts?.getElement(at: indexPath.row)?.id else {return}
            router?.product(for: mealId)
        }else{
            
        }
    }
}
// MARK: - ...  Cells
extension HomeVC {
    func sliderCell(for path: IndexPath) -> SliderCollectionCell {
        var cell = slidersCollection.cell(type: SliderCollectionCell.self, path)
        cell.model = adsRsult?.getElement(at: path.row)
        return cell
    }
    func categoryCell(for path: IndexPath) -> CategoryCollectionCell {
        var cell = categoriesCollection.cell(type: CategoryCollectionCell.self, path)
        cell.model = categoriesResult?.getElement(at: path.row)
        return cell
    }
    func productCell(for path: IndexPath) -> ProductCollectionCell {
        var cell = productsCollection.cell(type: ProductCollectionCell.self, path)
        cell.model = suggestedProducts?.getElement(at: path.row)
        return cell
    }
}

extension HomeVC: UITextFieldDelegate {
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        searchTxf.text = nil
//        searchTxf.endEditing(true)
//    }
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.text?.count ?? 0 > 1 {
//            router?.search(text: textField.text)
//        }
    }
}
