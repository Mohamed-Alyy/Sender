//
//  ProviderDetailsVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/21/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
//import CollieGallery
// MARK: - ...  ViewController - Vars
class ProviderDetailsVC: BaseController {
    @IBOutlet weak var resturantLbl: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
//    @IBOutlet weak var backgroundImageView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var resturantTypeLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var foodMenuBtn: UIButton!
    @IBOutlet weak var foodMenuUnderline: UIView!
    @IBOutlet weak var commentsBtn: UIButton!
    @IBOutlet weak var showMoreCommentsBtn: UIButton!
    @IBOutlet weak var commentsUnderline: UIView!
    @IBOutlet weak var foodMenuView: UIView!
    @IBOutlet weak var foodMenuTbl: UITableView!
    
    @IBOutlet weak var commentsView: UIView!
    @IBOutlet weak var commentsTbl: UITableView!
    @IBOutlet weak var onlineOfflineProviderLabel: UILabel!
    @IBOutlet weak var onlineOfflineProviderImage: UIImageView!
    @IBOutlet weak var cartNumberOfItems: UILabel!
    @IBOutlet weak var cartPrice: UILabel!
    var presenter: ProviderDetailsPresenter?
    var router: ProviderDetailsRouter?
    var provider: ProvidersResult?
//    var pictures = [CollieGalleryPicture]()
    var rates: [ProviderRatingsDatum]?
    var providerCategories: [ProviderCategoriesDatum]?
    var catgoryId: Int?
}

// MARK: - ...  LifeCycle
extension ProviderDetailsVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       
        presenter = .init()
        presenter?.view = self
        self.cart.presenter?.view = self
        router = .init()
        router?.view = self
        setup()
        setupImages()
        checkWorkTime()
        setupFoodMenu()
        setupComments()
        setupFavorite()
        foodMenu(foodMenuBtn ?? UIButton())
        guard let id = provider?.id else {return}
        super.cart.presenter?.getMyCart(providerId: id)
        presenter?.fetchCategories(categoryId: id)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ProviderDetailsVC {
    func setup() {
        cartNumberOfItems.text = "0" + " " + "item".localized
        resturantLbl.text = provider?.category?.title
        backgroundImage.setImage(url: provider?.avatar)
        logoImage.setImage(url: provider?.avatar)
        titleLbl.text = provider?.name
        addressBtn.setTitle(provider?.address, for: .normal)
        resturantTypeLbl.text = provider?.category?.title ?? ""
        rateLbl.text = provider?.rating?.double.string
        distanceLbl.text = provider?.distance ?? ""
    }
    func setupImages() {
//        for image in provider?.images ?? [] {
//            let picture = CollieGalleryPicture(url: image.img ?? "")
//            pictures.append(picture)
//        }
//        backgroundImageView.UIViewAction { [weak self] in
//            let gallery = CollieGallery(pictures: self?.pictures ?? [])
//            gallery.currentPageIndex = 0
//            guard let self = self else { return }
//            gallery.presentInViewController(self)
//        }
    }
    func setupFavorite() {
        if provider?.isLiked == 1 {
            favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteBtn.tintColor = R.color.thirdColor()
        } else {
            favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteBtn.tintColor = .white
        }
    }
    func setupFoodMenu() {
        foodMenuTbl.delegate = self
        foodMenuTbl.dataSource = self
        foodMenuTbl.reloadData()
        reloadHeight()
    }
    func setupComments() {
        commentsTbl.delegate = self
        commentsTbl.dataSource = self
        commentsTbl.estimatedRowHeight = 100
        commentsTbl.reloadData()
        commentsTbl.scrollToBottom()
        reloadHeight()
    }
  
    
    func checkWorkTime() {
        let isOpened = provider?.isOnline == 1
        onlineOfflineProviderLabel.text = isOpened ?  "Opened".localized : "Closed".localized
        onlineOfflineProviderImage.image = isOpened ? UIImage(named: "unRedDot")! : UIImage(named: "Offline")!
    }
    
    func foodMenu(_ enable: Bool = false) {
        if enable {
            foodMenuView.fadeIn(duration: 0.1) { (bool) in
                self.foodMenuView.isHidden = false
            }
            foodMenuBtn.setTitleColor(R.color.secondColor(), for: .normal)
            foodMenuUnderline.backgroundColor = R.color.secondColor()
        } else {
            foodMenuView.fadeOut(duration: 0.1) { (bool) in
                self.foodMenuView.isHidden = true
            }
            foodMenuBtn.setTitleColor(R.color.textColor3(), for: .normal)
            foodMenuUnderline.backgroundColor = R.color.borderColor2()
        }
    }
    
    func comments(_ enable: Bool = false) {
        if enable {
            commentsView.fadeIn(duration: 0.1) { (bool) in
                self.commentsView.isHidden = false
            }
            commentsBtn.setTitleColor(R.color.secondColor(), for: .normal)
            commentsUnderline.backgroundColor = R.color.secondColor()
        } else {
            commentsView.fadeOut(duration: 0.1) { (bool) in
                self.commentsView.isHidden = true
            }
            commentsBtn.setTitleColor(R.color.textColor3(), for: .normal)
            commentsUnderline.backgroundColor = R.color.borderColor2()
        }
    }
}

// MARK: - ...  Actions
extension ProviderDetailsVC {
    @IBAction func favorite(_ sender: Any) {
        provider?.like()
        setupFavorite()
    }
    @IBAction func share(_ sender: Any) {
        Common().shareApp(items: [provider?.name ?? "", provider?.address ?? "", logoImage.image ?? UIImage()])
    }
    @IBAction func foodMenu(_ sender: Any) {
        self.foodMenu(true)
        self.comments()
    }
  
    @IBAction func comments(_ sender: Any) {
        self.foodMenu()
        self.comments(true)
    }
    @IBAction func showMore(_ sender: Any) {
        router?.rates()
    }
    
    @IBAction func cart(_ sender: Any) {
        guard let id = provider?.id else {return}
        router?.cart(providerId: id)
    }
    
    @IBAction func didTappedOnDistance(_ sender: Any) {
        guard let lat = provider?.lat else {return}
        guard let lng = provider?.lng else {return}
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:
                                            "comgooglemaps://?saddr=&daddr=\(lat),\(lng)&directionsmode=driving")!)
        } else {
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(lng)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
    }
}
// MARK: - ...  View Contract
extension ProviderDetailsVC: ProviderDetailsViewContract,CartBuilderViewContract {
    func didFinishProcessOnCart() { }
    
    func didFetchRates(model: [ProviderRatingsDatum]?) {
        let count = model?.count ?? 0
        showMoreCommentsBtn.isHidden = count <= 3
        rates = model
        reloadHeight()
        commentsTbl.reloadData()
    }
    
    func didFetchCategories(model: [ProviderCategoriesDatum]?) {
        providerCategories = model
        reloadHeight()
        foodMenuTbl.reloadData()
    }
    
    func didFetchMyCart(cart: CartModel) {
        cartNumberOfItems.text = "\(cart.items?.count ?? 0)" + " " + "item".localized
        cartPrice.text = cart.totalPrice ?? "0"
    }
}

extension ProviderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func reloadHeight() {
        if let constraint = foodMenuTbl.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = 110 * (providerCategories?.count ?? 0).cgFloat
        }
        if let constraint = commentsTbl.constraints.first(where: { $0.firstAttribute == .height }) {
            let count = rates?.count ?? 0
            let visableCount = count <= 3 ? count : 3
            constraint.constant = 95 * visableCount.cgFloat
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == foodMenuTbl {
            return providerCategories?.count ?? 0
        } else {
            let count = rates?.count ?? 0
            return count <= 3 ? count : 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == foodMenuTbl {
            var cell = tableView.cell(type: CategoryTableCell.self, indexPath)
            cell.model = providerCategories?[indexPath.row]
            return cell
        } else {
            var cell = tableView.cell(type: RateTableCell.self, indexPath)
            cell.model = rates?.getElement(at: indexPath.row)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        reloadHeight()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == foodMenuTbl {
//            router?.requestMeal(with: provider?.subcategories?[indexPath.row])
            guard let scene = R.storyboard.providerMealsStoryboard.providerMealsVC() else { return }
            scene.provider =  provider
            scene.categories = providerCategories
            let selectedCategory = providerCategories?.getElement(at: indexPath.row)
            selectedCategory?.isSelected = true
            scene.selectedCategory = selectedCategory
            navigationController?.pushViewController(scene, animated: true)
        }
    }
}
