//
//  BaseViewController.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 19/11/20.
//
// ------- ORGANIZER PROJECT -------
//
// Struct All Class in the Project - MARKS in each Elements
//
// Imports (UIKit, RxSwifts, othres)
//
// IBOutlet Connections (Alls)
//
// Declaretions Variables and Constant (Objects, Strings, Int, others)
//
// Native Implementation (ViewDidLoad, ViewDidAppears, others)
//
// Override BaseController Implementacion (setupProgramView, setup, setupLanguage, others)
//
// Initial Custom Configurations Class (Personal Implementation)
//
// Initial Connection Outleek Action (Alls)
//
// End Function PrepareForSegue (End Funtion into Class)
//
// Extensions (Each Extension a Mark, TableView, CollectionView, others)
//
// ------- NOTE GENERAL -------
//
// -Always User R.generated (No use string descriptions)
// -Always Create Folder Class Struct (ViewController, ViewModels, Cells, Services)
// -Always LocalizableString name Struct - Falto
// -Always Struct Models Map Individual Class and group element three in Folder
// -Always Struct Database Realm Entity Indivuals an use Helper
// -Always user Rational Folder Resources (Nibs(Xibs), Fonts, Media(Assets), Strings, Ui)
// -Always Create Storyboard and group in Folder same elements (No more 3 view in Storyboard)
// -Possible-Always implementation SwiftLint (Concept Good Use Code)
// -Possible-Always Centralize Funtionality in Helpers (Structs, Enums, Othres)
// -Possible-Always Create Individual Extension Depend TypeValue
// -Possible-Always Create Real Stubbed each Services

//MARK: Imports
//MARK: IBOutlet Connections
//MARK: Declarations Variables and Constant
//MARK: Native Implementation
//MARK: Override BaseController Implementation
//MARK: Initial Custom Configurations Class
//MARK: Initial Connection Outleek Action
//MARK: Navigation
//MARK: Extensions

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController,UIGestureRecognizerDelegate {
    
    let screenSize              = UIScreen.main.bounds
    var titleLabel              : UILabel!
    var subTileButton           = UIButton(type: .custom)
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigatorBar(title: "Mercado Libre", subtitle: "Challenge")
        self.registerNib()
        self.setup()
        self.bindData()
        self.subscriptionData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func navigatorControllerHide(active:Bool){
        navigationController?.setNavigationBarHidden(active, animated: true)
    }
    
    func setup(){}
    func registerNib(){}
    @objc dynamic func bindData(){}
    @objc dynamic func subscriptionData(){}
    //Child Model
    
    func navigatorBar(title:String, subtitle:String?=nil){
        //background in navbar
        
        self.navigationController?.navigationBar.backgroundColor = R.color.yelowMeli()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.2
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        self.configNavigationBar()
        
        self.setNavigation(title: title, subtitle: subtitle)
    }
    
    func setNavigation(title:String, subtitle:String?){
        titleLabel.text  = title.uppercased()
        titleLabel.navigationTitleLabel()
        
        if(subtitle != nil){
            self.subTileButton.setTitle(subtitle, for: .normal)
            self.subTileButton.navigationSubTitleWithoutButton()
        }else{
            self.subTileButton.navigationSubTitleButton()
        }
    }
    
    func configNavigationBar(){
        
        //title view
        let view = UIView.init(frame:CGRect(x: 0, y: 0, width: Helper.size(size: 240) , height:Helper.size(size:64)))
        view.widthAnchor.constraint(equalToConstant: Helper.size(size: 240)).isActive = true
        
        //title Label
        titleLabel = UILabel.init(frame:CGRect(x: 0, y: 0, width: 200 , height:20))
        titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        //titleLabel.naviagtionTitleLabel()
        
        //subTitle Button
        subTileButton = UIButton.init(frame:CGRect(x: 0, y: 0, width: 200 , height:20))
        subTileButton.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        subTileButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        //subTileButton.naviagtionSubTitleButton()
        
        //Stack View
        let stackView   = UIStackView.init(frame:CGRect(x: view.frame.origin.x/2, y: view.frame.origin.y, width: screenSize.width*0.4 , height:64))
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = .center
        stackView.spacing   = 2.0
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTileButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 12.0, *) {
            view.addSubview(stackView)
            navigationItem.titleView = view
        }else{
            navigationItem.titleView = stackView
        }
    }
}
