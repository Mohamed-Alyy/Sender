//
//
//    Create by imac on 29/4/2018
//    Copyright © 2018. All rights reserved.

import Foundation
import UIKit
// MARK: - ...  UserAuth Controller
class UserRoot: Codable {
    // MARK: - ...  Keys UserDefaults
    public static var storeUserDefaults: String = "userDataDefaults"
    public static var storeRememberUser: String = "USER_LOGIN_REMEMBER"
    public static var storeTimeStamp: String = "LOGIN_TIMESTAMP"
    
    var data: User?
    var expire: Int?
    var refresh_token: String?
    var loginTimeStamp: Int?
    var token: String?
}
// MARK: - ...  User Codable from API
extension UserRoot {
    class User: Codable {
        let id: Int?
        let name, email, phone, gender: String?
        let birthdate, avatar: String?
        let active, confirmationCode, rating: Int?
        let userType: String?
        let age: String?
        let address: String?
        let points: String?
        let notRatedOrder: Int?
        let createdAt: String?
        enum CodingKeys: String, CodingKey {
            case id, name, email, phone, gender, birthdate, avatar, active
            case confirmationCode = "confirmation_code"
            case rating
            case userType = "user_type"
            case age, address
            case points
            case notRatedOrder
            case createdAt = "created_at"
        }
    }
}
// MARK: - ...  Functions
extension UserRoot {
    // MARK: - ...  Function for convert data to model
    public static func convertToModel(response: Data?) -> UserRoot {
        do {
            let data = try JSONDecoder().decode(self, from: response ?? Data())
            return data
        } catch {
            return UserRoot()
        }
    }
    // MARK: - ...  Function for Save user data
    public static func save(response: Data?, remember: Bool = true) {
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp).int
        UserDefaults.standard.set(response, forKey: storeUserDefaults)
        UserDefaults.standard.set(myTimeInterval, forKey: storeTimeStamp)
        if remember {
            UserDefaults.standard.set(true, forKey: storeRememberUser)
        }
    }
    // MARK: - ...  Function for Save user data
    public func save() {
        guard let response = try? JSONEncoder().encode(self) else { return }
        UserDefaults.standard.set(response, forKey: UserRoot.storeUserDefaults)
    }
    // MARK: - ...  Function for logout user
    public static func logout() {
        UserDefaults.standard.set(Data(), forKey: storeUserDefaults)
    }
    // MARK: - ...  Function for logout user
    public func logout() {
        UserDefaults.standard.set(Data(), forKey: UserRoot.storeUserDefaults)
    }
    // MARK: - ...  Function for fetch user data
    public static func fetch() -> UserRoot? {
        let data = UserDefaults.standard.data(forKey: storeUserDefaults)
        let user = self.convertToModel(response: data)
        return user
    }

    // MARK: - ...  Function for fetch user data
    public static func fetchUser() -> User? {
        let data = UserDefaults.standard.data(forKey: storeUserDefaults)
        let user = self.convertToModel(response: data)
        return user.data
    }
    // MARK: - ...  Function for fetch token 
    public static func token() -> String? {
        let data = UserDefaults.standard.data(forKey: storeUserDefaults)
        let user = self.convertToModel(response: data)
        print("user.token",user.token)
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODU5ZjBmMWQ4OTVhYmU4MDA5YzE5NTVmNTc5MjlhZDUwODljZjU2NjczOGRlOTc1Y2I3NTQyYTViZmJkZDJhZjhiNzQ3MjU1Zjk5MTE4ZWYiLCJpYXQiOjE2NjYyNTM0MTIuOTI1ODY5OTQxNzExNDI1NzgxMjUsIm5iZiI6MTY2NjI1MzQxMi45MjU4NzIwODc0Nzg2Mzc2OTUzMTI1LCJleHAiOjE2OTc3ODk0MTIuOTIyMTU5OTEwMjAyMDI2MzY3MTg3NSwic3ViIjoiNDQ2Iiwic2NvcGVzIjpbXX0.NwJmz2MyESRVEdyAXan6-9pGzboPyAFH5xeS7NdGKABA1bIMvjdsTzMipj9RUTNCGi_-32yQyeIfC-oGKKLLyaJiZpIvXoh06ZCNLN0hulZ6hORNZLe_dYyHhB4WRQhOH4CNCaW9LYRebmctcckhbkl_NKA2Ng4GkBPKtBxM_TzuuHijK4niDwn8YN-71uTLNNxDJYS6-LQlSj5Gu3PnQQKlvIvDyM8l50ksDYYmJWFge-XwMcoBu1upEjyOEhKc2peHgGv23yHKMdwGe47AMwVeYxOtLXFe-Eg-9g62L0XFP1bytb4CpkgsI5zETb26Cr6M972-w0A32LrQ-o5XmqIYAEcO5D3PNlGnadREbtvThDvU7f_N7WwBkiIsI9zk6DixMB1Ezb4o8-7loSVek4CQcEBWUh9MXhNrp68soDp9XSDcIgkT-ypkbgGCINRwMrEY9X6gowEO1P70tVjyq2w7isLTvLVW7t5xEJev295sykHd4h9WoovK_cSu2T5U3cca_vEJpZb_m02drLBSQseeH3Dkgps0-DhYRaq4kLGef2Kz6yzygcxSEpoINrQc8yETNluAg_X0K-kYJw1ijLcwKZa6DY72ITnl6EFbB2IQLK6ztfVU0LFk_xcSIXkB4fFQyes7P8LyB-BPOBLX5vI3s50CCt35JOw6OzGN1V0"
        return token
    }
    public static func authroize(closure: HandlerView? = nil) {
        if token() == nil {
            let scene = UIApplication.topViewController() as? BaseController
            PopupConfirmationVC.confirmationPOPUP(view: scene, title: "You must be logged in first!".localized, btns: [.agree, .skip]) {
                closure?()
                return
            } onAgreeClosure: {
                Router.instance.unAuthorized()
                return
            }
            return
        }
    }
}
