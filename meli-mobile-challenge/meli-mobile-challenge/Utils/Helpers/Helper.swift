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

    static func changeDateFormatWithDateString(dateString:String,format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let originalDate = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = format
        let formattedDateString = dateFormatter.string(from: originalDate)
        return formattedDateString
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
        let deviceWidth : CGFloat = screenWidth
        //375 is the base where the disign was made
        let newPropotion : CGFloat = (deviceWidth * (size / 375))
        //return the proportion
        return newPropotion
    }
    
    
    static func getProportionalSize(size:CGFloat,proportion:CGFloat)->CGFloat{
        
        let newPropotion : CGFloat = (size * proportion) /  contentScale
        //return the proportion
        return Helper.isSmallIphone() ? (newPropotion * 0.8) : (newPropotion * 0.9)
    }
    
    static func getProportionalSizeForLayout(size:CGFloat,proportion:CGFloat)->CGFloat{
        
        let newPropotion : CGFloat = (size * proportion) /  layoutScale
        //return the proportion
        return newPropotion
    }
    
    static func isIpad()->Bool{
        return (UIDevice.current.userInterfaceIdiom == .pad)
        
    }
    
    static func isSmallIphone()->Bool{
        return (UIScreen.main.bounds.size.height <= 568.0)
    }
    
    /// implement label in bottom of view  with number version and build
    static func getVersionAndBuild(viewMain:UIView){
        let versionString: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let BuildString: String = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        let versionLabel = UILabel()
        versionLabel.text = "\(versionString)(\(BuildString))"
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        viewMain.addSubview(versionLabel)
        
        versionLabel.centerXAnchor.constraint(equalTo: viewMain.centerXAnchor).isActive = true
        versionLabel.bottomAnchor.constraint(equalTo: viewMain.bottomAnchor, constant: -16).isActive = true
        
    }

}

extension String{
    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
}

