//
//  ProfileRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ProfileRouter: Router {
    typealias PresentingView = ProfileVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ProfileRouter: ProfileRouterContract {
    func editProfile() {
        guard let scene = R.storyboard.editProfileStoryboard.editProfileVC() else { return }
        view?.push(scene)
    }
    
    func favorites() {
        guard let scene = R.storyboard.favoritesStoryboard.favoritesVC() else { return }
        view?.push(scene)
    }
    
    func reservations() {
        guard let scene = R.storyboard.reservationsStoryboard.reservationsVC() else { return }
        view?.push(scene)
    }
    
    func cards() {
        let scene = CardsListVC.loadFromNib()
        view?.push(scene)
    }
    
    func goToWallet() {
        let scene = WalletVC.loadFromNib()
        view?.push(scene)
    }
    
    func goToLoyaltyPoints() {
        let scene = LoyaltyPointsVC.loadFromNib()
        view?.push(scene)
    }
    
    func logout() {
        UserRoot.logout()
        restart()
    }
    func addresses() {
        guard let scene = R.storyboard.addressesStoryboard.addressesVC() else { return }
        view?.push(scene)
//        scene.delegate = self
//        scene.fromProfile = true
//        self.view?.pushPop(scene)
    }
}
extension ProfileRouter: AddressesDelegate {
    func addresses(_ delegate: AddressesDelegate?, didCreate create: Bool) {
        guard let scene = R.storyboard.createAddressStoryboard.createAddressVC() else { return }
        scene.delegate = self
        //self.view?.push(scene)
        self.view?.navigationController?.present(scene, animated: true, completion: nil)
    }
    
    func addresses(_ delegate: AddressesDelegate?, for address: Int?) {
         
    }
    func addresses(_ delegate: AddressesDelegate?, for address: AddressesModel.Datum?) {
        guard let scene = R.storyboard.createAddressStoryboard.createAddressVC() else { return }
        scene.delegate = self
        scene.oldAddress = address
        //self.view?.push(scene)
        self.view?.navigationController?.present(scene, animated: true, completion: nil)
    }
}

extension ProfileRouter: CreateAddressDelegate {
    func createAddresses(_ delegate: CreateAddressDelegate?, didCreate create: Bool) {
        addresses()
    }
}
