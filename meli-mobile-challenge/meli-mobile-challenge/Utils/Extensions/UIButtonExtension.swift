//
//  UIButtonExtension.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 19/11/20.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import RxCocoa
import RxSwift

extension UIButton {
    func navigationSubTitleButton(){
        
        self.titleLabel?.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: 16)
        self.setTitleColor(.black, for: .normal)
        self.setImage(R.image.logoMeli(), for: .normal)
        self.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        self.imageEdgeInsets = UIEdgeInsets(top: 1, left: 90, bottom: 0, right: 90)
        self.isUserInteractionEnabled = true
        
    }
    
    func navigationSubTitleWithoutButton(){
        
        self.titleLabel?.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: 16)
        self.setTitleColor(.black, for: .normal)
        self.setImage(UIImage.init(), for: .normal)
        self.isUserInteractionEnabled = false
        
    }
    
    
}

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
