//
//  VerifyCodeInputs.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/29/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit


protocol VerifyCodeInputsDataSource: class {
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, view: Bool?) -> UIView?
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, txfs: Bool?) -> [UITextField]
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBorder: Bool?) -> UIColor
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, textBorder: Bool?) -> UIColor
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, completeBorder: Bool?) -> UIColor
}
extension VerifyCodeInputsDataSource {
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBorder: Bool?) -> UIColor {
        return .clear
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, textBorder: Bool?) -> UIColor {
        return .clear
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, completeBorder: Bool?) -> UIColor {
        return .clear
    }
}
class VerifyCodeInputs: NSObject {
    weak var dataSource: VerifyCodeInputsDataSource? {
        didSet {
            setup()
            resetBorderColors()
        }
    }
    var code1Txf: UITextField? {
        return dataSource?.verifyCodeInputs(self, txfs: true)[safe: 0]
    }
    var code2Txf: UITextField? {
        return dataSource?.verifyCodeInputs(self, txfs: true)[safe: 1]
    }
    var code3Txf: UITextField? {
        return dataSource?.verifyCodeInputs(self, txfs: true)[safe: 2]
    }
    var code4Txf: UITextField? {
        return dataSource?.verifyCodeInputs(self, txfs: true)[safe: 3]
    }
    var view: UIView? {
        return dataSource?.verifyCodeInputs(self, view: true)
    }
    var code: String? {
        var string = ""
        if Localizer.current == .arabic {
            string = "\(code4Txf?.text ?? "")\(code3Txf?.text ?? "")\(code2Txf?.text ?? "")\(code1Txf?.text ?? "")"
        } else {
            string = "\(code1Txf?.text ?? "")\(code2Txf?.text ?? "")\(code3Txf?.text ?? "")\(code4Txf?.text ?? "")"
        }
        if string.count == (dataSource?.verifyCodeInputs(self, txfs: true).count ?? 0) {
            return string
        } else {
            return nil
        }
    }
    func setup() {
        code1Txf?.delegate = self
        code2Txf?.delegate = self
        code3Txf?.delegate = self
        code4Txf?.delegate = self
        code1Txf?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        code2Txf?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        code3Txf?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        code4Txf?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        code1Txf?.keyboardType = .numberPad
        code2Txf?.keyboardType = .numberPad
        code3Txf?.keyboardType = .numberPad
        code4Txf?.keyboardType = .numberPad
    }
    func resetBorderColors() {
        code1Txf?.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
        code2Txf?.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
        code3Txf?.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
        code4Txf?.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
    }
    
}
 

// MARK:  Text fielde delegate
extension VerifyCodeInputs: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.borderColor = dataSource?.verifyCodeInputs(self, textBorder: true)

        switch textField {
            case code1Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code1Txf?.text = ""
                    }
                }
            case code2Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code2Txf?.text = ""
                    }
                }
            case code3Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code3Txf?.text = ""
                    }
                }
            case code4Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code4Txf?.text = ""
                    }
                }
            default:
                break
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.count > 0 {
                textField.superview?.borderColor = dataSource?.verifyCodeInputs(self, completeBorder: true)
            } else {
                textField.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
            }
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if Localizer.current == .arabic {
            setupArabic(textField)
            return
        }
        switch textField {
            case code1Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code2Txf?.becomeFirstResponder()
                    } else {
                        view?.endEditing(true)
                    }
                }
            case code2Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code3Txf?.becomeFirstResponder()
                    } else {
                        code1Txf?.becomeFirstResponder()
                    }
                }
            case code3Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code4Txf?.becomeFirstResponder()
                    } else {
                        code2Txf?.becomeFirstResponder()
                    }
                }
            case code4Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        textField.endEditing(true)
                    } else {
                        code3Txf?.becomeFirstResponder()
                    }
                }
            default:
                break
        }
    }
    func setupArabic(_ textField: UITextField) {
        switch textField {
            
            case code4Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code3Txf?.becomeFirstResponder()
                    } else {
                        view?.endEditing(true)
                    }
                }
            case code3Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code2Txf?.becomeFirstResponder()
                    } else {
                        code4Txf?.becomeFirstResponder()
                    }
                }
            case code2Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        code1Txf?.becomeFirstResponder()
                    } else {
                        code3Txf?.becomeFirstResponder()
                    }
                }
            case code1Txf:
                if let text = textField.text {
                    if text.count > 0 {
                        view?.endEditing(true)
                    } else {
                        code2Txf?.becomeFirstResponder()
                    }
                }
            default:
                break
        }
    }
}
