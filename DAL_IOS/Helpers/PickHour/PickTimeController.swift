//
//  Login.swift
//  SupportI
//
//  Created by Adam on 3/16/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import UIKit
class PickTimeController: BaseController {
    enum PickType {
        case date
        case time
    }
    @IBOutlet weak var timePicker: UIDatePicker!

    var time: String?
    var timeDisplay: String?
    var type: PickType = .date
    var closureTime: ((Date) -> Void)?
    var minDate: Date?
    var maxDate: Date?
    var useMaxDate: Bool = false
    var setMiniDate: Bool = true
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    func setup() {
        //timePicker.minimumDate = Date()
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        } else {
        }
        if type == .date {
            timePicker.datePickerMode = .date
        } else {
            timePicker.datePickerMode = .time
        }
        if type == .date {
            if setMiniDate {
                timePicker.minimumDate = Date()
            }
        }
        
        
        timePicker.locale = Locale(identifier: Localizer.current.rawValue)
        if useMaxDate == true {
            timePicker.minimumDate = minDate
            timePicker.maximumDate = maxDate
            if minDate != nil {
                timePicker.date = minDate!
            }
        }
    }
    override func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func complete(_ sender: Any) {
        self.dismiss(animated: true) {
            self.closureTime?(self.timePicker.date)
        }
    }
}
