//
//  DetailViewModel.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 21/11/20.
//

import Foundation
import RxCocoa
import RxSwift
import NVActivityIndicatorView
import RxDataSources

class DetailViewModel {
    
    var getProductById: AnyObserver<String>!
    var getDescriptionById: AnyObserver<String>!
    var responseProduct : Observable<ProductDetailResponseModel> = Observable.just(ProductDetailResponseModel())
    var responseDescription : Observable<DescriptionResponseModel> = Observable.just(DescriptionResponseModel())
    var progress = NVActivityIndicatorView(frame: CGRect.zero)
    let indicator = ActivityIndicator()
    
    init(){
        getProduct()
        getDescription()
    }
    
    func getProduct(){
        let _getProductById = PublishSubject<String>()
        self.getProductById = _getProductById.asObserver()
        
        indicator.asDriver()
            .drive(progress.rx_animating)
            .disposed(by: disposeBag)
        
        self.responseProduct = _getProductById
            .flatMapLatest({ param -> Observable<ProductDetailResponseModel> in
                return Api.requestService(endpoint: .fetchItem(parameters: ["ids":param]) , model: ProductDetailResponseModel()).trackActivity(self.indicator)
            }).catchError({ (error) -> Observable<ProductDetailResponseModel> in
                Helper.shared.showAlertWithHandler("", message: error.domain)
                return .error(error)
            }).retry().map({ result  in
                return result
            })
    }
    
    func getDescription(){
        let _getDescriptionById = PublishSubject<String>()
        self.getDescriptionById = _getDescriptionById.asObserver()
        
        indicator.asDriver()
            .drive(progress.rx_animating)
            .disposed(by: disposeBag)
        
        self.responseDescription = _getDescriptionById
            .flatMapLatest({ param -> Observable<DescriptionResponseModel> in
                return Api.requestService(endpoint: .fetchDescription(productId: param) , model: DescriptionResponseModel()).trackActivity(self.indicator)
            }).catchError({ (error) -> Observable<DescriptionResponseModel> in
                Helper.shared.showAlertWithHandler("", message: error.domain)
                return .error(error)
            }).retry().map({ result  in
                return result
            })
    }
}
