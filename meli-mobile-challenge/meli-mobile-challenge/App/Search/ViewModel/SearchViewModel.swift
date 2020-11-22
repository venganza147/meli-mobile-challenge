//
//  SearchViewModel.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 20/11/20.
//

import Foundation
import RxCocoa
import RxSwift
import NVActivityIndicatorView
import RxDataSources

class SearchViewModel {
    
    var getAllProducts: AnyObserver<String>!
    var responseAllList : Observable<SearchItemsModel> = Observable.just(SearchItemsModel())
    var progress = NVActivityIndicatorView(frame: CGRect.zero)
    let indicator = ActivityIndicator()
    
    init(){
        getListAllProducts()
    }
    
    func getListAllProducts(){
        let _getAllProducts = PublishSubject<String>()
        self.getAllProducts = _getAllProducts.asObserver()
        
        indicator.asDriver()
            .drive(progress.rx_animating)
            .disposed(by: disposeBag)
        
        self.responseAllList = _getAllProducts
            .flatMapLatest({ param -> Observable<SearchItemsModel> in
                return Api.requestService(endpoint: .searchItems(parameters: ["q":param]) , model: SearchItemsModel()).trackActivity(self.indicator)
            }).catchError({ (error) -> Observable<SearchItemsModel> in
                Helper.shared.showAlertWithHandler("", message: error.domain)
                return .error(error)
            }).retry().map({ result  in
                return result
            })
    }
}
