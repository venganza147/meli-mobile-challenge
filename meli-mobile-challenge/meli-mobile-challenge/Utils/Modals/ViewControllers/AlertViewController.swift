//
//  AlertViewController.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 18/11/20.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

enum AlertType{
    case alert
    case confirm
    case Edit
}

enum AlertImage{
    case logo
    case question
    case warning
    case error
    case share
    case wifi
    case success
    case edit
    case custom
}

class AlertViewController: UIViewController {
    
    // MARK: - IBActions
    @IBOutlet weak var imageContent: UIView!
    @IBOutlet weak var alertContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titlealertLabel: UILabel!
    @IBOutlet weak var messageAlertLabel: UILabel!
    @IBOutlet weak var buttonsContainerView: UIView!
    @IBOutlet weak var editTextView: UITextView!
    @IBOutlet weak var alertWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Vars
    var optionsStack : UIStackView = UIStackView()
    var acceptButton : UIButton = UIButton(type: .custom)
    var cancelButton : UIButton = UIButton(type: .custom)
    var alertType    : AlertType = .alert
    var alertImage   : AlertImage = .logo
    var allowEmptyField: Bool     = false
    
    var messageAlertText = ""
    var titleAlertText   = ""
    var cancelButtonText = "Cancel"
    var acceptButtonText = "OK"
    let optionSelected   = PublishSubject<Int>()
    let textEdited   = PublishSubject<String>()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.bindData()
        self.titlealertLabel.text   = titleAlertText.uppercased()
        
        self.messageAlertLabel.text = messageAlertText
        self.editTextView.text = messageAlertText
        self.adjustUITextViewHeight(arg: editTextView)
        self.configImage()
        self.editTextView.layer.borderColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:1.0).cgColor
        self.editTextView.layer.borderWidth = 1
        self.editTextView.layer.cornerRadius = 6
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configAlertWidth()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.alertContainerView.layoutSubviews()
        self.alertContainerView.layoutIfNeeded()
        self.imageContent.layoutIfNeeded()
        self.imageContent.layer.cornerRadius = self.imageContent.frame.size.width/2.0
        self.imageContent.layer.masksToBounds = true
        self.imageContent.clipsToBounds = true
    }
    
    // MARK: - General
    func configImage(){
        var image = UIImage()
        
        switch alertImage {
        case .error:
            image = R.image.alertError()!
        case .question:
            image = R.image.alertQuestion()!
        case .share:
            image = R.image.alertShare()!
        case .success:
            image = R.image.alertChecked()!
        case .warning:
            image = R.image.alertInfo()!
        case .wifi:
            image = R.image.alertWifi()!
        case .edit:
            image = R.image.alertEdit()!
        default:
            image = R.image.alertInfo()!
        }
        imageView.image = image
        
        if(alertImage == .logo){
            self.imageContent.backgroundColor = UIColor.green.withAlphaComponent(0.2)
            self.imageContent.layoutIfNeeded()
            print(self.imageContent.frame.size.width)
            print(self.imageContent.frame.size.height)
            self.imageContent.layer.cornerRadius = self.imageContent.frame.size.width/2.0
            self.imageContent.layer.masksToBounds = true
            self.imageContent.clipsToBounds = true
        }
    }
    
    func setup(){
        self.configButtons()
        self.configFont()
        self.configContentStyle()
        
        self.optionsStack.axis = .horizontal
        optionsStack.distribution = .fillEqually
        optionsStack.spacing = Helper.size(size: 5.0)
        optionsStack.alignment = .center
        
        if(self.alertType == .alert){
            optionsStack.addArrangedSubview(acceptButton)
            
        }else if(self.alertType == .confirm || self.alertType == .Edit){
            optionsStack.addArrangedSubview(cancelButton)
            optionsStack.addArrangedSubview(acceptButton)
            
        }
        
        if self.alertType == .Edit {
            self.editTextView.isHidden = false
            self.messageAlertLabel.isHidden = true
            self.editTextView.becomeFirstResponder()
        }
        
        if(!self.buttonsContainerView.subviews.contains(optionsStack)){
            self.buttonsContainerView.addSubview(optionsStack)
            
            self.optionsStack.translatesAutoresizingMaskIntoConstraints = false
            
            self.optionsStack.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                self.optionsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.optionsStack.topAnchor.constraint(equalTo: view.topAnchor),
                self.optionsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.optionsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            
//            self.optionsStack.snp.makeConstraints { m in
//                m.centerX.equalToSuperview()
//                m.centerY.equalToSuperview()
//                m.width.equalToSuperview()
//                m.height.equalToSuperview()
//            }
            
            let horizontalLine = UIView()
            horizontalLine.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            self.buttonsContainerView.addSubview(horizontalLine)
            
//            horizontalLine.snp.makeConstraints { m in
//                m.width.equalToSuperview()
//                m.height.equalTo(0.5)
//                m.bottom.equalTo(self.buttonsContainerView.snp.top).offset(-6)
//                m.centerX.equalToSuperview()
//            }
        }
    }
    
    func configContentStyle(){
        self.alertContainerView.layer.cornerRadius  = Helper.size(size: 10.0)
        self.alertContainerView.layer.borderColor   = UIColor.black.withAlphaComponent(0.5).cgColor
        self.alertContainerView.layer.borderWidth   = 1.0
        
        self.alertContainerView.layer.shadowColor   = UIColor.black.cgColor
        self.alertContainerView.layer.shadowOffset  = CGSize(width: 0, height: 1.0)
        self.alertContainerView.layer.shadowOpacity = 0.2
        self.alertContainerView.layer.shadowRadius  = 4.0
    }
    
    func configFont(){
        titlealertLabel.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: Helper.size(size: 18.0))
        messageAlertLabel.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: Helper.size(size: 15.0))
        
    }
    
    func configButtons(){
        acceptButton.setTitle(self.acceptButtonText.uppercased(), for: .normal)
        acceptButton.titleLabel!.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: Helper.size(size: 16.0))
        acceptButton.setTitleColor(.green, for: .normal)
        
        cancelButton.setTitle(self.cancelButtonText.uppercased(), for: .normal)
        cancelButton.titleLabel!.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: Helper.size(size: 16.0))
        cancelButton.setTitleColor(.green, for: .normal)
        
    }
    
    func configAlertWidth(){
        editTextView.centerVertically()
        switch UIApplication.shared.statusBarOrientation {
        case .portrait, .portraitUpsideDown, .unknown:
            self.configFont()
            var newConstraint = self.alertWidthConstraint.constraintWithMultiplier(0.75)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                newConstraint = self.alertWidthConstraint.constraintWithMultiplier(0.40)
            }
            
            view.removeConstraint(self.alertWidthConstraint)
            view.addConstraint(newConstraint)
            view.layoutIfNeeded()
            self.alertWidthConstraint = newConstraint
            break
        case .landscapeLeft,.landscapeRight:
            
            titlealertLabel.font   = R.font.harabaraMaisBoldHarabaraMaisBold(size: Helper.size(size: 15.0))
            messageAlertLabel.font = R.font.harabaraMaisBoldHarabaraMaisBold(size: Helper.size(size: 10.0))
            
            var newConstraint = self.alertWidthConstraint.constraintWithMultiplier(0.45)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                newConstraint = self.alertWidthConstraint.constraintWithMultiplier(0.20)
            }
            
            
            view.removeConstraint(self.alertWidthConstraint)
            view.addConstraint(newConstraint)
            view.layoutIfNeeded()
            self.alertWidthConstraint = newConstraint
            break
            
        @unknown default:
            let newConstraint = self.alertWidthConstraint.constraintWithMultiplier(0.75)
            view.removeConstraint(self.alertWidthConstraint)
            view.addConstraint(newConstraint)
            view.layoutIfNeeded()
            self.alertWidthConstraint = newConstraint
            break
        }
    }
    
    func registerNib(){}
    
    // MARK: - Bind Data
    func bindData(){
        self.acceptButton.rx.tap.subscribe(onNext: { _ in
            print("accept")
            if self.alertType == .Edit {
                self.optionSelected.onNext(1)
                let textToValidate = self.editTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
                if textToValidate != "" {
                    self.textEdited.onNext(self.editTextView.text)
                    self.dismiss(animated: false)
                }else {
                    if !self.allowEmptyField {
                        AlertHelper.alert(message: "The field cannot be empty")
                    }else {
                        self.textEdited.onNext(self.editTextView.text)
                        self.dismiss(animated: false)
                    }
                }
        
            } else {
                self.optionSelected.onNext(1)
                if self.editTextView.text != "" {
                    self.textEdited.onNext(self.editTextView.text)
                }
                self.dismiss(animated: false)
            }
        }).disposed(by: disposeBag)
        
        self.cancelButton.rx.tap.subscribe(onNext: { _ in
            print("cancel")
            self.optionSelected.onNext(2)
            self.dismiss(animated: false)
        }).disposed(by: disposeBag)

    }
    func subscriptionData(){
        
    }
}

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
