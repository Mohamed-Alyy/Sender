//
//  TestViewController.swift
//  DAL_IOS
//
//  Created by Mohamed Ali on 18/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit


class ProviderInfoVC: UIViewController {
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var personalDataBtnOutlet: UIButton!
    @IBOutlet weak var StoreDataBtnOutlet: UIButton!
    @IBOutlet weak var workTimesBtnOutlet: UIButton!
    
    @IBOutlet weak var workDaysCollection: UICollectionView!
    @IBOutlet weak var pickerDays: UIPickerView!
    @IBOutlet weak var personalDataView: UIView!
    @IBOutlet weak var storeDataView: UIView!
    @IBOutlet weak var workTimesView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationHelper.delegate=self
        imageGallery.delegate=self
        //storeDataViPzew.isHidden = false
        personalDataView.isHidden = true
        workTimesView.isHidden = true
        navigationController?.navigationBar.tintColor = .black
        addBarButtons()
        registerCells()
        workDaysCollection.layer.borderWidth = 0.5
        workDaysCollection.cornerRadius = 5
        pickerDays.isHidden = true
        personalDataBtnOutlet.backgroundColor = UIColor(named: "OrangGradient1")
        personalDataBtnOutlet.tintColor = .white
    }
    
    // MARK: - Proerties
    
    
    var buttonsTag = 0
    let weekDays = ["Saturday" , "Sunday" , "Monday" , "Tuesday" , "Wednesday" , "Thursday"]
    var workDaysArray: [String] = []
    
    // photos for upload
    var photoId: UIImage?
    var photoLicense: UIImage?
    var photoComercialRegister: UIImage?
    var savePhotoClousre: ((_ photo:UIImage)->Void)?
 
    // instance object helper
    let imageGallery = GalleryPickerHelper()
    let imagePickerDelegat:  GalleryPickerHelper? = nil
    let locationHelper = LocationHelper()
    
    
    // MARK: - Actions
    @IBAction func providerButtonsPressed(_ sender: UIButton) {
        showView(tag: sender.tag)
        
    }
    
    @IBAction func addNewDayBtnPressed(_ sender: UIButton) {
        pickerDays.isHidden = !pickerDays.isHidden
        
    }
    
    @IBAction func uploadPhotoIdButnPressed(_ sender: UIButton) {
       // addImageFromGalary()
        imageGallery.pickGallery(in: self)
        savePhotoClousre = { [weak self] photo in
            guard let self = self else {return}
                    self.photoId = photo
          //  self.imageIdUrl = GalleryPickerHelper.getImageURL(image: photo)
            print(self.photoId?.bytesSize as Any)
        //    print(self.imageIdUrl)
        }
        
    }
    
    @IBAction func uplladPhotoLicenseBtnPressed(_ sender: UIButton) {
        //addImageFromGalary()
        imageGallery.pickGallery(in: self)
        savePhotoClousre = { [weak self] photo in
            guard let self = self else {return}
                    self.photoLicense = photo
            print(self.photoLicense?.bytesSize as Any)
        }
        
    }
    
    @IBAction func uploadComercialPhotoBtnPressed(_ sender: UIButton) {
        
        imageGallery.pickGallery(in: self)
        
//        addImageFromGalary()
        savePhotoClousre = { [weak self] photo in
            guard let self = self else {return}
            self.photoComercialRegister = photo
            print(self.photoComercialRegister?.bytesSize as Any)
        }
    }
    
    
    @IBAction func getLoactionButtonPressed(_ sender: UIButton) {
        
       // let location = locationHelper.location
        
    }
    
    // MARK: - Functions
    
    
    func registerCells(){
        workDaysCollection.register(cell: WeekDaysCollectionViewCell.self)
        workDaysCollection.delegate=self
        workDaysCollection.dataSource=self
        
        pickerDays.delegate=self
        pickerDays.dataSource=self
    }
    
    func showView (tag: Int){
        switch tag{
        case 0:

            storeDataView.isHidden = false
            personalDataView.isHidden = true
            workTimesView.isHidden = true
            
            personalDataBtnOutlet.backgroundColor = UIColor(named: "OrangGradient1")
            personalDataBtnOutlet.tintColor = .white
            StoreDataBtnOutlet.backgroundColor = .white
            StoreDataBtnOutlet.tintColor = .black
            workTimesBtnOutlet.backgroundColor = .white
            workTimesBtnOutlet.tintColor = .black
            
        case 1:

            personalDataView.isHidden = false
            storeDataView.isHidden = true
            workTimesView.isHidden = true
            
            personalDataBtnOutlet.backgroundColor = .white
            personalDataBtnOutlet.tintColor = .black
            StoreDataBtnOutlet.backgroundColor = UIColor(named: "OrangGradient1")
            StoreDataBtnOutlet.tintColor = .white
            workTimesBtnOutlet.backgroundColor = .white
            workTimesBtnOutlet.tintColor = .black
            
        case 2:

            workTimesView.isHidden = false
            personalDataView.isHidden = true
            storeDataView.isHidden = true
            
            personalDataBtnOutlet.backgroundColor = .white
            personalDataBtnOutlet.tintColor = .black
            StoreDataBtnOutlet.backgroundColor = .white
            StoreDataBtnOutlet.tintColor = .black
            workTimesBtnOutlet.backgroundColor = UIColor(named: "OrangGradient1")
            workTimesBtnOutlet.tintColor = .white
            
        default:
            personalDataView.isHidden = true
            
        }
    }
  
    func addBarButtons(){
        let back = UIBarButtonItem(image: UIImage(named: "back-black"), style: .plain, target: self, action: nil)
        
        let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItem = save
        self.navigationItem.leftBarButtonItem = back
    }
    
 
} // Class End


extension ProviderInfoVC: LocationDelegate{
    
}

// MARK: - Extension: WorkDaysDelegateProtocol
extension ProviderInfoVC: WorkDaysDelegateProtocol{
    func didXbuttonTapped(cellRow: Int) {
        workDaysArray.remove(at: cellRow)
        workDaysCollection.reloadData()
    }
}


// MARK: - Extension: ImagePickerDelegate
extension ProviderInfoVC: ImagePickerDelegate {
    func didPickItem(image: UIImage) {
        photoComercialRegister = image
        savePhotoClousre!(image)
    }
}



// MARK: - Extension: CollectionView
extension ProviderInfoVC : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workDaysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDaysCollectionViewCell", for: indexPath) as? WeekDaysCollectionViewCell {
            
            cell.dayTitle.text = workDaysArray[indexPath.row]
            cell.currentCell = indexPath.row
            cell.delegate=self
            return cell
        }
        return UICollectionViewCell()
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width
        let height = collectionView.height
        
        return CGSize(width: width * 0.35 , height: height - 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.zero
    }
    
    
}


// MARK: - Extension: UIPickerView
extension ProviderInfoVC: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        weekDays.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        weekDays[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        workDaysArray.append(weekDays[row])
        workDaysCollection.reloadData()
        pickerView.isHidden = true
    }
   
}

