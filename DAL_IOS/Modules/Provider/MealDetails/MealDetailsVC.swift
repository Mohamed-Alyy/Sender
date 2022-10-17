//
//  MealDetailsVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import Cosmos
// MARK: - ...  ViewController - Vars
class MealDetailsVC: BaseController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var stockLbl: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var extrasTbl: UITableView!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var quantityView: QuantityView!
    @IBOutlet weak var outOfStockView: UIView!
    @IBOutlet weak var addToCartView: UIView!
    var presenter: MealDetailsPresenter?
    var router: MealDetailsRouter?
    var meal: ProviderCategoriesMealsDatum? {
        didSet {
            let stock = meal?.stock ?? 0
            outOfStockView?.isHidden = stock != 0
            quantityView?.isHidden = stock == 0
            addToCartView?.isHidden = stock == 0
        }
    }
    var mealID: Int?
    var fromCart: Bool = false
    
    var price: Double {
        return Double(totalPriceLbl.text ?? "0") ?? 0
    }
    var selectedExtras: [AdditionsModel] {
        var extras: [AdditionsModel] = []
        for extra in meal?.additions ?? [] {
            if extra.isChecked == true && extra.quantity ?? 0 > 0 {
                extras.append(extra)
            }
        }
        return extras
    }
   
}

// MARK: - ...  LifeCycle
extension MealDetailsVC {
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
        quantityView.item = nil
        if let mealId = mealID{
            startLoading()
            presenter?.fetchMeal(mealID: mealId)
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension MealDetailsVC {
    
    func setup() {
        backgroundImage.setImage(url: meal?.image)
        titleLbl.text = meal?.name
        stockLbl.text = "\(meal?.stock ?? 0)" + " " + "Stock".localized
        pointLbl.text = "0" + " " + "Loyalty Points".localized
        rateView.rating = meal?.rating?.double ?? 0
        priceLbl.text = "\(meal?.price ?? "0") \("SAR.short".localized)"
//        rateLbl.text = "(\(meal?.rating ?? 0)/5)"
        caloriesLbl.text = "\(meal?.calories ?? 0) \("calory".localized)"
        detailsLbl.text = meal?.datumDescription
        quantityView.delegate = self
        quantityView.dataSource = self
    }
    func checkInCart() {
        if fromCart {
            let item = cart.list().first(where: {$0.product?.id == mealID})
            if item != nil {
                meal?.id = item?.product?.id
                meal?.quantity = item?.quantity
                meal?.calories = item?.product?.calories
                meal?.stock = item?.product?.stock
//                let mealAdditions = meal?.additions ?? []
//                let itemAdditions = item?.additions ?? []
//                let result = zip(mealAdditions, itemAdditions).enumerated().filter()  {
//                    if $1.0.id == $1.1.id {
//                        $1.0.isChecked = true
//                        $1.0.quantity = $1.1.quantity
//                    }
//                    return true
//                }.map{$0.element.0}
//                meal?.additions = result
                
//                meal?.additions?.forEach({$0.isChecked = true})
//                meal?.additions?.forEach({$0.price = $0.peicePrice})
//                meal?.additions?.forEach({$0.id = $0.additionId})
                meal?.name = item?.product?.name
                meal?.price = item?.product?.price ?? "0" 
                meal?.image = item?.product?.image
//                noteTxf.text = item?.notes
                quantityView.dataSource = self
                checkInCartExtras(item: item)
            }
        }
    }
    func checkInCartExtras(item: CartModel.Cart?) {
        for extraID in 0..<(item?.additions ?? []).count {
            for index in 0..<(meal?.additions ?? []).count {
                if item?.additions?[extraID].additionId == (meal?.additions?[index].id ?? 0 ){
                    meal?.additions?[index].isChecked = true
                    meal?.additions?[index].quantity = item?.additions?[extraID].quantity
                }
            }
        }
        setupExtras()
    }
    func updatePrices() {
        DispatchQueue.main.async {
            var price = 0.0
            
            var extraPrices = 0.0
            for extra in self.selectedExtras {
                let extraPrice = (Double(extra.price ?? "0") ?? 0) * (extra.quantity ?? 0).double
                extraPrices += extraPrice
            }
            if ( self.meal?.quantity == nil || self.meal?.quantity ?? 0 == 0) {
                //meal?.quantity = 1
                self.quantityView.plus()
            }
            price += (self.meal?.quantity ?? 0).double * (Double(self.meal?.price ?? "0") ?? 0)
            price += extraPrices
            self.totalPriceLbl.text = price.string
        }
        
    }
     
    
    func setupExtras() {
        extrasTbl.delegate = self
        extrasTbl.dataSource = self
        extrasTbl.reloadData()
        extrasTbl.scrollToBottom()
        reloadHeight()
    }
}
extension MealDetailsVC {
    
    
    
    @IBAction func addCart(_ sender: Any) { 
        if price > 0 {
            startLoading()
            cart.presenter?.view = self
            if let id = meal?.id {
                cart.insertToCart(isEdit: fromCart, productId: id, quantity: meal?.quantity ?? 1,selectedExtras: selectedExtras)
                
            }
            
        } else {
            openConfirmation(title: "Sorry, the meal cannot be added to the basket. You must at least choose the quantity of the meal".localized)
        }
    }
}
// MARK: - ...  View Contract
extension MealDetailsVC: MealDetailsViewContract, PopupConfirmationViewContract, CartBuilderViewContract {
    
    func didFetchMyCart(cart: CartModel) {
        
    }
    
    func didFinishProcessOnCart() {
        stopLoading()
        if fromCart {
            self.navigationController?.popViewController()
        }else{
            guard let providerId = meal?.provider?.id else {return}
            
            router?.cart(providerId: providerId)
        }
        
    }
    
    func didFetchMeal(for meal: ProviderCategoriesMealsDatum?) {
        stopLoading()
        self.meal = meal
        setup()
        checkInCart()
        updatePrices()
        setupExtras()
    }
}

extension MealDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedExtras.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.cell(type: PlusExtraMealCell.self, indexPath)
            cell.delegate = self
            return cell
        } else {
            var cell = tableView.cell(type: ExtraMealCell.self, indexPath)
            cell.model = selectedExtras[safe: indexPath.row - 1]
            cell.delegate = self
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    func reloadHeight() {
        if let constraint = extrasTbl.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant =  100 * (selectedExtras.count.cgFloat + 1)
        }
    }
}

// MARK: - ...  Quantity view
extension MealDetailsVC: QuantityViewDelegate, QuantityViewDataSource {
    func quantityView(_ view: QuantityView?) -> QuantityModel? {
        return meal
    }
    func quantityView(_ view: QuantityView?, didChange item: QuantityModel?) {
        meal?.quantity = item?.quantity ?? 0
        updatePrices()
    }
}
// MARK: - ...  add extra cell delegate
extension MealDetailsVC: PlusExtraMealDelegate {
    func plusExtraMeal(didPlus cell: PlusExtraMealCell) {
        router?.extras()
    }
}

// MARK: - ...  Extra meal pop up selected meal
extension MealDetailsVC: MealExtrasDelegate {
    func mealExtras(_ delegate: MealExtrasDelegate?, for meal: ProviderCategoriesMealsDatum?) {
        self.meal = meal
        setupExtras()
        updatePrices()
    }
}

// MARK: - ...  Extra meal cell delegate for remove extra from seleced
extension MealDetailsVC: ExtraMealCellDelegate {
    func extraMealCell(for cell: ExtraMealCell) {
        let extra = selectedExtras[safe: cell.indexPath() - 1]
        for index in 0..<(meal?.additions?.count ?? 0) {
            if meal?.additions?[index].id == extra?.id {
                meal?.additions?[index].isChecked = false
                meal?.additions?[index].quantity = nil
                setupExtras()
                updatePrices()
                break
            }
        }
    }
}

extension MealDetailsVC: ImageDisplayInterface {

}
