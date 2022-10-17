import CoreData
import Alamofire
// MARK: - ...  NetworkManager
class NetworkManager: BaseNetworkManager, Authorization {
    
    struct Static {
        static var instance: NetworkManager?
    }
    
    class var instance: NetworkManager {
        if Static.instance == nil {
            Static.instance = NetworkManager()
        }
        return Static.instance!
    }
    
    
    var useAuth: Bool = NetworkConfigration.useAuth
}

// MARK: - ...  functions
extension NetworkManager {
    
    
    func request<M: Codable>(_ method: String, type: HTTPMethod, _ model: M.Type, completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if self.useAuth {
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    super.connection(method, type: type, BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
        } else {
            super.refresh()
            super.connection(method, type: type, BaseModel<M>.self, completionHandler: completionHandler)
        }
    }
    
    func request<M: Codable>(_ method: NetworkConfigration.EndPoint, type: HTTPMethod, _ model: M.Type, completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        self.request(method.rawValue, type: type, model, completionHandler: completionHandler)
    }
    
    func requestRaw<M: Codable>(_ method: String, type: HTTPMethod, _ model: M.Type, completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if self.useAuth {
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    super.connectionRaw(method, type: type,  BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
        } else {
            super.refresh()
            super.connectionRaw(method, type: type,  BaseModel<M>.self, completionHandler: completionHandler)
        }
    }
    
    
    func requestRaw<M: Codable>(_ method: String, json: Data, type: HTTPMethod, _ model: M.Type, completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if self.useAuth {
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    super.connectionRaw(method, type: type, json: json, BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
        } else {
            super.refresh()
            super.connectionRaw(method, type: type, json: json, BaseModel<M>.self, completionHandler: completionHandler)
        }
    }
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [URL]? = [], key: String? = "",
                                      file: [String: URL?]? = nil, _ model: M.Type,
                                      completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if self.useAuth {
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    super.uploadMultiFiles(method, type: type, files: files ?? [], key: key ?? "", file: file, BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
        } else {
            super.refresh()
            super.uploadMultiFiles(method, type: type, files: files ?? [], key: key ?? "", file: file, BaseModel<M>.self, completionHandler: completionHandler)
        }
    }
    
    
    func uploadMultiImages<M: Codable>(_ method: String , type: HTTPMethod, files: [UIImage]? = [], key: String? = "",
                                       file: [String: UIImage?]? = nil, _ model: M.Type,
                                       completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if self.useAuth {
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    super.uploadMultiFiles(method, type: type, files: files ?? [], key: key ?? "", file: file, BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
        } else {
            super.refresh()
            super.uploadMultiFiles(method, type: type, files: files ?? [], key: key ?? "", file: file, BaseModel<M>.self, completionHandler: completionHandler)
        }
    }
}
