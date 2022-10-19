//
//  Ex_LoadUI.swift
//  DAL_IOS
//
//  Created by Mohamed Khaled on 18/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView{
    func loadImage(urlString:String,defaultImage :String = "lighting"){
        guard let url = URL(string: urlString) else{return}
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        let defaultImage = UIImage(named: defaultImage)
        self.kf.setImage(with: resource, placeholder: defaultImage)
    }
}
