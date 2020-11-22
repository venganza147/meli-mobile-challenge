//
//  ApiManager.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 17/11/20.
//

import Foundation
import RxSwift
import NVActivityIndicatorView
import Alamofire
import Moya

let defaultManager: Alamofire.Session = {
    let manager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: ["191.132.202.108": DisabledTrustEvaluator()])
    let configuration = URLSessionConfiguration.af.default
    
    return Session(configuration: configuration, serverTrustManager: manager)
}()

let ApiProvider = MoyaProvider<Api>(session: defaultManager)
var disposeBag = DisposeBag()
private let allowedDiskSize = 100 * 1024 * 1024
var cache: URLCache = {
    return URLCache(memoryCapacity: 100, diskCapacity: allowedDiskSize, diskPath: "requestCache")
}()

extension Api {
    static func requestService<T: Codable>(endpoint:Api,model:T,fromCache:Bool = false) -> Observable<T> {
        
        return Observable<T>.create { (observer) -> Disposable in
            
            if !fromCache {
                if let cachedData =  self.validateCacheRequest(endpoint: endpoint){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        //                    print(debugPrint(cachedData.data))
                        let model = try! JSONDecoder().decode(T.self, from:  cachedData.data, keyPath:"data")
                        observer.onNext(model)
                        observer.onCompleted()
                    }
                }
            }else {
                print("dont cache")
            }
            
            ApiProvider.session.sessionConfiguration.urlCache = cache
            if #available(iOS 11.0, *) {
                ApiProvider.session.sessionConfiguration.waitsForConnectivity = true
            }
            ApiProvider.rx.request(endpoint).timeout(120, scheduler: MainScheduler.instance)
                .subscribe { event in
                    
                    switch event {
                    
                    case let .success(response):
                        
                        switch response.statusCode{
                        case 200...299:
                            print("responde el servicio",endpoint)
                            if canCache(endpoint: endpoint) {
                                let cachedData = CachedURLResponse(response: response.response!, data: response.data)
                                cache.storeCachedResponse(cachedData, for: response.request!)
                            }
                            
                            if let model = try? response.map(T.self, atKeyPath: "data", using: JSONDecoder.init(), failsOnEmptyData: false) {
                                observer.onNext(model)
                                observer.onCompleted()
                            }else if  let simpleModel = try? response.map(T.self) {
                                observer.onNext(simpleModel)
                                observer.onCompleted()
                            }else {
                                Helper.removeLoadingForError()
                                observer.onCompleted()
                                print("JSONDecoder Model error")
                            }
                            
                        default:
                            Helper.removeLoadingForError()
                            let errorMap : ErrorModel? = try? response.map(ErrorModel.self)
                            let error = NSError(domain: errorMap?.message ?? "Server Error", code: response.statusCode, userInfo: nil)
                            
                            if error.code == 401 {
                                Helper.shared.showAlertWithHandler("Session Expired", message: "Your session is expired, please login again")
                            }else {
                                
                                observer.onError(error)
                                observer.onCompleted()
                            }
                            break
                        }
                        
                    case let .error(error):
                        print(error)
                        Helper.removeLoadingForError()
                        Helper.shared.showAlertWithHandler("", message: "Request Time out")
                        NVActivityIndicatorPresenter
                            .sharedInstance
                            .stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
                        observer.onCompleted()
                    }
                }.disposed(by: disposeBag)
            
            return Disposables.create {
            }
        }
    }
    
    static func validateCacheRequest(endpoint:Api) -> CachedURLResponse?{
        switch endpoint {
        case .fetchDescription,
             .fetchItem,
             .searchItems
        :
            let url = endpoint.baseURL.absoluteString + endpoint.path
            return cache.cachedResponse(for: URLRequest(url: URL(string: url)!))
        }
    }
    
    static func canCache(endpoint:Api) -> Bool{
        switch endpoint {
        case .fetchDescription,
             .fetchItem,
             .searchItems
        :
            return true
        }
    }
    
    func toJson(from object:Any) -> Data? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        
        return data
    }
}
