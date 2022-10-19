//
//  FilterResultsVC.swift
//  DAL_IOS
//
//  Created by mac on 18/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class FilterResultsVC: BaseController {

    @IBOutlet weak var viewDesign: UIView!
    @IBOutlet weak var fromDateTF: UITextField!
    @IBOutlet weak var toDateTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDesign.makeCornerFromTopLR([.topLeft,.topRight], radius: 20)
    }
    
    
    @IBAction func fromDate(_ sender: UITextField) {
        fromDateTF.resignFirstResponder()
    }
    
    @IBAction func toDate(_ sender: UITextField) {
        toDateTF.resignFirstResponder()
    }
    
    @IBAction func editAction(_ sender: Any) {
        // your code..
        dismiss(animated: true)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
