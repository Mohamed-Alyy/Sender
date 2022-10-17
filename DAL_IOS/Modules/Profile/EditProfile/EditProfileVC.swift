//
//  EditProfileVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class EditProfileVC: BaseController {
    @IBOutlet weak var userImage: UIImageView!
//    @IBOutlet weak var userNameLbl: UILabel!
//    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameEditTxf: EditTextFieldView!
    @IBOutlet weak var emailEditTxf: EditTextFieldView!
    @IBOutlet weak var phoneEditTxf: EditTextFieldView!
//    @IBOutlet weak var passwordEditTxf: EditTextFieldView!
//    @IBOutlet weak var addressEditTxf: EditTextFieldView!
//    @IBOutlet weak var ageEditTxf: EditTextFieldView!
//    @IBOutlet weak var sexEditTxf: EditSelectView!
    var presenter: EditProfilePresenter?
    var router: EditProfileRouter?
    var user: UserRoot.User? {
        return UserRoot.fetchUser()
    }
    var paramters: [String: Any] = [:]
    var avatarImage: UIImage?
    lazy var imagePicker: GalleryPickerHelper? = {
        let picker = GalleryPickerHelper()
        picker.onPickImage = { [weak self] image in
            self?.userImage.image = image
            self?.avatarImage = image
            self?.presenter?.update()
        }
        return picker
    }()
}

// MARK: - ...  LifeCycle
extension EditProfileVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
// MARK: - ...  Functions
extension EditProfileVC {
    func setup() {
        phoneEditTxf.textTxf.keyboardType = .asciiCapableNumberPad
        emailEditTxf.textTxf.keyboardType = .asciiCapable
        userImage.setImage(url: user?.avatar)
//        userNameLbl.text = user?.name
//        emailLbl.text = user?.email
        nameEditTxf.text = user?.name
        emailEditTxf.text = user?.email
        phoneEditTxf.text = user?.phone
//        addressEditTxf.text = user?.address
//        ageEditTxf.text = user?.age
//        sexEditTxf.text = (user?.gender ?? "MALE").localized
//        ageEditTxf.textTxf.keyboardType = .asciiCapableNumberPad
//        ageEditTxf.textTxf.maxChar = 2
        
        nameEditTxf.delegate = self
        emailEditTxf.delegate = self
        phoneEditTxf.delegate = self
//        addressEditTxf.delegate = self
//        ageEditTxf.delegate = self
//        sexEditTxf.delegate = self
    }
}
extension EditProfileVC {
    @IBAction func pickImage(_ sender: Any) {
        imagePicker?.pick(in: self)
    }
    
    @IBAction func changePassword(_ sender: Any) {
        router?.editPassword()
    }
    
    @IBAction func didTappedDeleteAccount(_ sender: Any) {
        openConfirmation(title: "Delete Account! \n Are You Sure?", btns: [.agree,.skip], onAgreeClosure:  {
            self.presenter?.deleteAccount()
        })
    }
}
// MARK: - ...  View Contract
extension EditProfileVC: EditProfileViewContract, PopupConfirmationViewContract {
    func didDeleteSuccess(message: String) {
        openConfirmation(title: "Delete Account! \n Are You Sure?", btns: [.agree], onAgreeClosure:  {
            UserRoot.logout()
        })
    }
    
    func didSuccess(withUser id: Int) {
        
    }
    func didFail(error: String?) {
        openConfirmation(title: error, btns: [.skip])
    }
}

extension EditProfileVC: LocationFromMapDelegateContract {
    func saveLocation(lat: Double?, lng: Double?, address: String?) {
        paramters["lat"] = lat
        paramters["lng"] = lng
        paramters["address"] = address
//        addressEditTxf.text = address
    }
    func didFailLocation() {
        
    }
}
extension EditProfileVC: EditViewDelegate {
    func editView(didSave view: EditTextFieldView) {
        self.presenter?.update()
    }
    func editView(didEdit view: EditTextFieldView) {
//        if view == addressEditTxf {
//            self.router?.openMap()
//        }
    }
    func editView(didSave selectView: EditSelectView) {
        self.presenter?.update()
    }
}

