//
//  AlertHelper.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 18/11/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

public class AlertHelper {
    
    /// This method shows a custom alert with message, title and one option
    ///
    /// - Parameters:
    ///     - message: message to be shown in the confirm view. (REQUIRED)
    ///     - title: title to be shown in the confirm view. Empty by default (OPTIONAL)
    ///     - okButton: Ok Button title. "OK" by default (OPTIONAL)
    ///     - alertImage: Image to be shown in the top of the view (OPTIONAL) App Logo by defautl
    ///     - completion: Return a Bool value
    static func alert(message : String, title : String = "", okButton : String = "OK", alertImage : AlertImage = .logo, completion : @escaping (_ result: Bool) -> Void = { _ in }){
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            let vc                      = R.storyboard.modals.alertVC()!
            vc.modalPresentationStyle   = .overCurrentContext
            vc.messageAlertText         = message
            vc.acceptButtonText         = okButton
            vc.alertType                = .alert
            vc.alertImage               = alertImage
            let vc2                     = UIApplication.shared.keyWindow?.rootViewController?.getTopMostViewController()!
            vc2!.present(vc, animated: false, completion: nil)
            
            vc.optionSelected.subscribe(onNext: { option in
                completion((option == 1))
            }).disposed(by: disposeBag)
        })
    }
    
    /// This method shows a custom confirm alert with message, title and two options.
    ///
    /// - Parameters:
    ///     - message: message to be shown in the confirm view. (REQUIRED)
    ///     - title: title to be shown in the confirm view. Empty by default (OPTIONAL)
    ///     - cancelButton: Cancel Button title. "Cancel" by default (OPTIONAL)
    ///     - okButton: Ok Button title. "OK" by default (OPTIONAL)
    ///     - alertImage: Image to be shown in the top of the view (OPTIONAL) App Logo by defautl
    ///     - completion: Return a Bool value, ok=true cancel=false
    static func confirm(message : String, title : String = "", cancelButton : String = "Cancel", okButton : String = "OK", alertImage : AlertImage = .logo, completion : @escaping (_ result: Bool)->()){
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            let vc                      = R.storyboard.modals.alertVC()!
            vc.modalPresentationStyle   = .overCurrentContext
            vc.messageAlertText         = message
            vc.titleAlertText           = title
            vc.acceptButtonText         = okButton
            vc.cancelButtonText         = cancelButton
            vc.alertType                = .confirm
            vc.alertImage               = alertImage
            let vc2                     = UIApplication.shared.keyWindow?.rootViewController?.getTopMostViewController()!
            vc2!.present(vc, animated: false, completion: nil)
            
            vc.optionSelected.subscribe(onNext: { option in
                completion((option == 1))
            }).disposed(by: disposeBag)
        })
    }
    
    
    static func edit(message : String, title : String = "", cancelButton : String = "Cancel", okButton : String = "OK", alertImage : AlertImage = .edit, completion : @escaping (_ result: String)->(),allowEmptyField:Bool = false){
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            let vc                      = R.storyboard.modals.alertVC()!
            vc.modalPresentationStyle   = .overCurrentContext
            vc.messageAlertText         = message
            vc.titleAlertText           = title
            vc.acceptButtonText         = okButton
            vc.cancelButtonText         = cancelButton
            vc.alertType                = .Edit
            vc.alertImage               = alertImage
            vc.allowEmptyField          = allowEmptyField
            let vc2                     = UIApplication.shared.keyWindow?.rootViewController?.getTopMostViewController()!
            vc2!.present(vc, animated: false, completion: nil)
            
            vc.textEdited.subscribe(onNext: { text in
                completion(text)
               
            }).disposed(by: disposeBag)
        })
    }
}
