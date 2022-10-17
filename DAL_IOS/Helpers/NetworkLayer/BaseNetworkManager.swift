import Alamofire

// MARK: - ...  Base Network manager // downloader // paginator // alertable
class BaseNetworkManager: Downloader, Paginator, Alertable {
    let url = NetworkConfigration.URL
    var paramaters: [String: Any] = [:]
    var headers: [String: String] = [:]
    var isHttpRequestRun: Bool = false
    override init() {
        super.init()
        setupObject()
        //        tryNetwork(url: "www.google.com")
        //        subscribeNotification()
    }
}
// MARK: - ...  Functions setup
extension BaseNetworkManager {
    // MARK: - ...  refresh for new request
    func refresh() {
        setupObject()
//        paginate()
    }
    // MARK: - ...  setup request object
    func setupObject() {
        //hide()
        setupAuth()
        headers["version"] = NetworkConfigration.VERSION
        headers["Device"] = Constants.DEVICEID
        headers["lang"] = Localizer.current.rawValue
        headers["Accept-Language"] = Localizer.current.rawValue
        headers["Accept"] = "application/json"
        //        paramaters["lang"] = Localizer.current
    }
    // MARK: - ...  setup auth header
    func setupAuth() {
                if let token = UserRoot.token() {
                    headers["Authorization"] = "Bearer \(token)"
//                    paramaters["user_id"] = UserRoot.fetch()?.data?.id
               }
        //headers["Authorization"] = Authentication.shared.getAuthHeader()
        
    }
    // MARK: - ...  reset the object
    func resetObject() {
        self.paramaters = [:]
        setupObject()
    }
    // MARK: - ...  initailize the FULL URL
    func initURL(method: String, type: HTTPMethod) -> String {
        var url = ""
        if type == .get {
            let methodFull = queryString(method: method)
            url = self.url+methodFull
        } else {
            url = self.url+method
        }
        return url
    }
}
// MARK: - ...  Handle response for request
extension BaseNetworkManager {
    func response<M: Codable>(response: DataResponse<Any>, _ model: BaseModel<M>.Type ,completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        print(response.result.value ?? "")
        self.isHttpRequestRun = false
        switch response.result {
            case .success:
                switch response.response?.statusCode {
                    case 200?:
                        do {
                            guard let data = response.data else { return }
                            let model = try JSONDecoder().decode(M.self, from: data)
                            completionHandler(.success(model))
                        } catch DecodingError.typeMismatch(let type , let context) {
                            let error = "Type \(type) mismatch: \(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                            print(error)
                            return completionHandler(.failure(NetworkError.init(message: error)))
                        } catch DecodingError.keyNotFound(let key, let context) {
                            let error = "Key \(key) mismatch: \(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                            print(error)
                            return completionHandler(.failure(NetworkError.init(message: error)))
                        } catch DecodingError.valueNotFound(let value, let context) {
                            let error = "Value \(value) mismatch: \(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                            print(error)
                            return completionHandler(.failure(NetworkError.init(message: error)))
                        } catch DecodingError.dataCorrupted(let context) {
                            let error = "\(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                            return completionHandler(.failure(NetworkError.init(message: error)))
                        } catch {
                            return completionHandler(.failure(error))
                        }
                    case 201?:
                        do {
                            let model = try JSONDecoder().decode(BaseModel<M>.self, from: response.data ?? Data())
                            completionHandler(.success(model.data))
                        } catch { return completionHandler(.failure(error)) }
                    case 400?:
                        UIApplication.topViewController()?.stopLoading()
                    let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                        completionHandler(.failure(error))
                    case 401?:
                        UIApplication.topViewController()?.stopLoading()
                        Router.instance.unAuthorized()
                    case 404?:
                        UIApplication.topViewController()?.stopLoading()
                        let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                        completionHandler(.failure(error))
                    case 422?:
                        UIApplication.topViewController()?.stopLoading()
                        let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                        completionHandler(.failure(error))
                    case 426?:
                        UIApplication.topViewController()?.stopLoading()
                        let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                        completionHandler(.failure(error))
                default:
                    UIApplication.topViewController()?.stopLoading()
                    let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                UIApplication.topViewController()?.stopLoading()
                self.makeAlert(error.localizedDescription, closure: {})
            //self.show()
        }
    }
}
// MARK: - ...  Connections
extension BaseNetworkManager {
    // MARK: - ...  Basic request with type
    func connection<M: Codable>(_ method: String, type: HTTPMethod, _ model: BaseModel<M>.Type,
                                completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        self.isHttpRequestRun = true
        let url = initURL(method: method, type: type)
        print(url)
        let paramters = self.paramaters
        print(paramters)
        self.resetObject()
        Alamofire.request(safeUrl(url: url), method: type, parameters: paramters, headers: self.headers)
            .responseJSON { response in
                self.response(response: response, model, completionHandler: completionHandler)
            }
    }
    // MARK: - ...  Advanced request for raw
    func connectionRaw<M: Codable>(_ method: String, type: HTTPMethod, _ model: BaseModel<M>.Type,
                                   completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        self.isHttpRequestRun = true
        let url = initURL(method: method, type: type)
        print(url)
        let paramters = self.paramaters
        self.resetObject()
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        var request = URLRequest(url: URL(string: safeUrl(url: url))!)
        do {
            let data = try JSONSerialization.data(withJSONObject: paramters, options: [])
            let paramString = String(data: data, encoding: String.Encoding.utf8)
            request.httpBody = paramString?.data(using: .utf8)
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        headers["Content-Type"] =  "application/json"
        request.httpMethod = type.rawValue
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
        Alamofire.request(request)
            .responseJSON { response in
                print(response.result.value ?? "")
                self.isHttpRequestRun = false
                self.response(response: response, model, completionHandler: completionHandler)
            }
    }
    // MARK: - ...  Advanced request for raw with json object
    func connectionRaw<M: Codable>(_ method: String, type: HTTPMethod, json: Data?,_ model: BaseModel<M>.Type,
                                   completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        self.isHttpRequestRun = true
        let url = initURL(method: method, type: type)
        print(url)
        self.resetObject()
        //        if (self.paramater1 == ""){
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        var request = URLRequest(url: URL(string: safeUrl(url: url))!)
        let paramString = String(data: json ?? Data(), encoding: String.Encoding.utf8)
        request.httpBody = paramString?.data(using: .utf8)
        headers["Content-Type"] =  "application/json"
        request.httpMethod = type.rawValue
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
        Alamofire.request(request)
            .responseJSON { response in
                print(response.result.value ?? "")
                self.isHttpRequestRun = false
                self.response(response: response, model, completionHandler: completionHandler)
            }
    }
    // MARK: - ...  Advanced request for upload files & only file // type URL
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [URL], key: String,
                                      file: [String: URL?]? = nil, _ model: BaseModel<M>.Type,
                                      completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        self.isHttpRequestRun = true
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()
        Alamofire.upload(multipartFormData: { multipartFormData in
            var counter = 0
            files.forEach({ (item) in
                multipartFormData.append(item, withName: "\(key)[\(counter)]")
                counter += 1
            })
            if file != nil {
                file?.forEach({ (fileData) in
                    if let url = fileData.value {
                        multipartFormData.append(url, withName: "\(fileData.key)")
                    }
                })
            }
            for (key, value) in paramters {
                if let id = value as? Int {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else if let id = value as? Double {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else {
                    let string = value as? String
                    multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                }
            } //Optional for extra parameters
        },to: url, headers: headers) { (result) in
            switch result {
                case .success(let upload, _, _):
                    self.presenting()
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                        self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                        var progress = self.progressView.progress
                        progress *= 100
                        self.label.text = "\(Int(progress))"+"%"
                    })
                    upload.responseJSON { response in
                        self.restore()
                        self.isHttpRequestRun = false
                        print(response.result.value ?? "")
                        self.response(response: response, model, completionHandler: completionHandler)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    UIApplication.topViewController()?.stopLoading()
                    self.makeAlert(encodingError.localizedDescription, closure: {})
            }
        }
    }
    // MARK: - ...  Advanced request for upload files & only file // type UIImage
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [UIImage], key: String, file: [String: UIImage?]? = nil, _ model: BaseModel<M>.Type,
                                      completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        self.isHttpRequestRun = true
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()
        Alamofire.upload(multipartFormData: { multipartFormData in
            var counter = 0
            for item in files {
                //multipartFormData.append(item, withName: "\(key)[\(counter)]")
                multipartFormData.append(item.jpegData(compressionQuality: 0.5) ?? Data(),
                                         withName: "\(key)[\(counter)]", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                counter += 1
            }
            //            files.forEach({ (item) in
            //
            //            })
            if file != nil {
                file?.forEach({ (fileData) in
                    if let image = fileData.value {
                        multipartFormData.append(image.jpegData(compressionQuality: 0.5) ?? Data(),
                                                 withName: "\(fileData.key)", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                        
                    }
                })
            }
            for (key, value) in paramters {
                if let id = value as? Int {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else if let id = value as? Double {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else {
                    let string = value as? String
                    multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                }
            } //Optional for extra parameters
        },to: url, headers: headers) { (result) in
            switch result {
                case .success(let upload, _, _):
                    self.presenting()
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                        self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                        var progress = self.progressView.progress
                        progress *= 100
                        self.label.text = "\(Int(progress))"+"%"
                    })
                    upload.responseJSON { response in
                        self.restore()
                        self.isHttpRequestRun = false
                        print(response.result.value ?? "")
                        self.response(response: response, model, completionHandler: completionHandler)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    UIApplication.topViewController()?.stopLoading()
                    self.makeAlert(encodingError.localizedDescription, closure: {})
            }
        }
    }
}
