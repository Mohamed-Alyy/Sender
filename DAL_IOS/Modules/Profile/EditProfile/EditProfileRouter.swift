//
//  EditProfileRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class EditProfileRouter: Router {
    typealias PresentingView = EditProfileVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension EditProfileRouter: EditProfileRouterContract {
    func openMap() {
        guard let scene = R.storyboard.locationFromMapStoryboard.locationFromMapVC() else { return }
        scene.delegate = view
        self.view?.pushPop(scene)
    }
    func profile() {
        for controller in view?.navigationController?.viewControllers ?? [] {
            if controller is ProfileVC {
                view?.navigationController?.popToViewController(controller, animated: true)
            }
        }
    }
    
    func editPassword() {
        let scene = SetNewPasswordVC.loadFromNib() 
        view?.push(scene)
    }
}
