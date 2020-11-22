//
//  Helper.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 17/11/20.
//

import UIKit
import NVActivityIndicatorView
import RxSwift
import RxCocoa
import Photos

enum Config {
    case url
}

public class Helper {
    
    public static let shared = Helper()
    
    static func config(attr : Config)->String{
        let config : [String:String] = Bundle.main.infoDictionary!["CONFIG"] as! [String:String]
        
        var attributeValue = ""
        
        switch attr {
        case .url:
            attributeValue = config["API_URL"]!
        }
        
        return attributeValue
    }
    
    func showAlertWithHandler(_ title:String,message msg:String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Accept", style: .default) { (action) in
            
            UIApplication.shared.keyWindow?.rootViewController = R.storyboard.main.instantiateInitialViewController()
            
        }
        alertController.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.getTopMostViewController()?.present(alertController, animated: true, completion: nil)
        
    }
    
    static func removeLoadingForError() {
        let loadings = UIApplication.shared.keyWindow?.rootViewController?.getTopMostViewController()?.view.subviews.filter{$0 is NVActivityIndicatorView}
        if loadings?.count ?? 0 > 0 {
            loadings?.first?.removeFromSuperview()
        }
    }
    
    static func size(size:CGFloat)->CGFloat{
        if(isIpad()){
            let size2 = size * 1.3
            return size2
        }
        //Device width
        let deviceWidth : CGFloat = UIScreen.main.bounds.size.width
        //375 is the base where the disign was made
        let newPropotion : CGFloat = (deviceWidth * (size / 375))
        //return the proportion
        return newPropotion
    }
    
    static func isIpad()->Bool{
        return (UIDevice.current.userInterfaceIdiom == .pad)
    }
    
    static func isSmallIphone()->Bool{
        return (UIScreen.main.bounds.size.height <= 568.0)
    }
    
}
