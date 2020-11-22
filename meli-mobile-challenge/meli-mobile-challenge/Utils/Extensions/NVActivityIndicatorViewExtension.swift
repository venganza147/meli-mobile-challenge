//
//  NVActivityIndicatorViewExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 22/11/20.
//

import Foundation
import NVActivityIndicatorView
import RxCocoa
import RxSwift

extension NVActivityIndicatorView {
    public var rx_animating: AnyObserver<Bool> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()
            
            switch event {
            case .next(let value):
                if value {
                    if Connectivity.isConnectedToInternet {
                        
                        let size = CGSize(width: 50,
                                          height: 50)
                        let activityData = ActivityData(size: size,
                                                        message: "",
                                                        type: .circleStrokeSpin)
                        
                        NVActivityIndicatorPresenter
                            .sharedInstance
                            .startAnimating(activityData, NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
                    }
                } else {
                    NVActivityIndicatorPresenter
                        .sharedInstance
                        .stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
                }
            case .error(let error):
                print(error.localizedDescription)
                NVActivityIndicatorPresenter
                    .sharedInstance
                    .stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
            case .completed:
                NVActivityIndicatorPresenter
                    .sharedInstance
                    .stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
                break
            }
        }
    }
}
