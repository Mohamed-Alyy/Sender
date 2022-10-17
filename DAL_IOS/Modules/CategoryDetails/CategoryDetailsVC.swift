//
//  CategoryDetailsVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class CategoryDetailsVC: BaseController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var resturantsTbl: UITableView!
//    @IBOutlet weak var nationalityCollection: UICollectionView! {
//        didSet {
//            if let layout = nationalityCollection.collectionViewLayout as? UICollectionViewFlowLayout {
//                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//            }
//        }
//    }
    @IBOutlet weak var foodTypeCollection: UICollectionView! {
        didSet {
            if let layout = foodTypeCollection.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
        }
    }
    var presenter: CategoryDetailsPresenter?
    var router: CategoryDetailsRouter?
    var category: CategoriesResult?
    var providers: [Provider] = []
    var nationalities: [FilterOptionModel.Feature] = []
    var foodTypes: [FilterOptionModel.Category] = []
    var selectedNationality: Int? = 0
    var selectedFoodType: Int? = 0 
    lazy var location: LocationHelper? = {
        let helper = LocationHelper()
        helper.onUpdateLocation = { [weak self] degree in
            
        }
        helper.onErrorLocation = {
            
        }
        return helper
    }()
}

// MARK: - ...  LifeCycle
extension CategoryDetailsVC {
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
//        setupAllCell()
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension CategoryDetailsVC {
    func setup() {
//        presenter?.fetchFilter()
        titleLbl.text = category?.title
        resturantsTbl.delegate = self
        resturantsTbl.dataSource = self
        foodTypeCollection.dataSource = self
        foodTypeCollection.delegate = self
//        nationalityCollection.dataSource = self
//        nationalityCollection.delegate = self
//
        providers.removeAll()
        startLoading()
        presenter?.options["category_id"] = category?.id
        presenter?.fetchProviders()
    }
    func setupAllCell() {
        nationalities.removeAll()
        foodTypes.removeAll()
        nationalities.append(.init(id: 0, name: "All".localized, active: 1, checked: false))
        foodTypes.append(.init(id: 0, img: nil, name: "All".localized, count: 0, type: nil, active: 1, categoryID: 0, checked: false))
    }
}
extension CategoryDetailsVC {
    @IBAction func filter(_ sender: Any) {
        router?.filter()
    }
}
// MARK: - ...  View Contract
extension CategoryDetailsVC: CategoryDetailsViewContract {
    func didFetchProviders(for list: [Provider]?) {
        stopLoading()
        providers.append(contentsOf: list ?? [])
        resturantsTbl.stopSwipeButtom()
        resturantsTbl.reloadData {
            
        }
    }
    func didFetchFilter(for model: FilterOptionModel.DataClass?) {
        nationalities.append(contentsOf: model?.nationality ?? [])
        foodTypes.append(contentsOf: model?.subcategories ?? [])
//        nationalityCollection.reloadData()
        foodTypeCollection.reloadData()
    }
}

extension CategoryDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == resturantsTbl {
            if self.presenter?.canPaginate() == true {
                resturantsTbl.swipeButtomRefresh { [weak self] in
                    self?.presenter?.fetchProviders()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: ResturantTableCell.self, indexPath)
        cell.model = providers.getElement(at:indexPath.row)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.provider(for: providers.getElement(at: indexPath.row))
    }
}

extension CategoryDetailsVC: FavoriteCellDelegate {
    func favoriteCell(for cell: CellProtocol) {
        //providers[cell.indexPath()].swipeLike()
        resturantsTbl.reloadData()
    }
}

extension CategoryDetailsVC: LocationFromMapDelegateContract {
    func saveLocation(lat: Double?, lng: Double?, address: String?) {
        presenter?.options["lat"] = "\(lat ?? 0)"
        presenter?.options["lng"] = "\(lng ?? 0)"
        presenter?.fetchProviders()
    }
    func didFailLocation() {
        
    }
}

extension CategoryDetailsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return   foodTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.cell(type: CategoryDetailFilterCell.self, indexPath)
        if indexPath.row == selectedFoodType {
            cell.isChecked = true
        } else {
            cell.isChecked = false
        }
//        cell.model = foodTypes[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == nationalityCollection {
//            selectedNationality = indexPath.row
//        } else {
//            selectedFoodType = indexPath.row
//        }
        selectedFoodType = indexPath.row
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        categoryFilter()
    }
}
extension CategoryDetailsVC {
    func categoryFilter() {
//        if selectedNationality ?? 0 > 0 {
//            presenter?.options["resturant"] = nationalities[selectedNationality ?? 0].id
//        }
//        if selectedFoodType ?? 0 > 0 {
//            presenter?.options["food"] = foodTypes[selectedFoodType ?? 0].id
//        }
//        startLoading()
//        presenter?.fetchProviders()
//        providers.removeAll()
//        presenter?.resetPaginator()
    }
}
//
//extension CategoryDetailsVC: CategoryFilterDelegate {
//    func categoryFilter(_ delegate: CategoryFilterDelegate?, for options: [String : Any]) {
//        for option in options {
//            presenter?.options[option.key] = option.value
//        }
//        startLoading()
//        presenter?.fetchProviders()
//        providers.removeAll()
//        presenter?.resetPaginator()
//    }
//}
