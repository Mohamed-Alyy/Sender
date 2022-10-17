//
//  EditViewDelegate.swift
//  DAL_Provider
//
//  Created by M.abdu on 2/3/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

protocol EditViewDelegate: NSObjectProtocol {
    func editView(didEdit view: EditTextFieldView)
    func editView(didSave view: EditTextFieldView)
    func editView(didSave selectView: EditSelectView)
}

extension EditViewDelegate {
    func editView(didEdit view: EditTextFieldView) {
        
    }
    func editView(didSave view: EditTextFieldView) {
        
    }
    func editView(didSave selectView: EditSelectView) {
        
    }

}
