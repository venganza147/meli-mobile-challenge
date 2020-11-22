//
//  DetailViewController.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 21/11/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailViewController: BaseViewController {
    var productId: String?
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var imagesScrollView: UIScrollView!
    
    
    var detailViewModel = DetailViewModel()
    var productDetail = BehaviorRelay<ProductDetailResponseModel>(value: ProductDetailResponseModel())
    var productDescription = BehaviorRelay<DescriptionResponseModel>(value: DescriptionResponseModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.detailViewModel.getProductById.onNext(productId ?? "")
        self.detailViewModel.getDescriptionById.onNext(productId ?? "")
    }
    
    override func setup() {
        imagesScrollView.alwaysBounceHorizontal = true
        imagesScrollView.showsHorizontalScrollIndicator = false
        imagesScrollView.isPagingEnabled = true
        imagesScrollView.backgroundColor = UIColor.white
        
        productTitleLabel.text = ""
        productPriceLabel.text = ""
        productDescriptionLabel.text = ""
    }
    
    override func bindData() {
        productDetail.asObservable().subscribe(onNext: { (productDetail) in
            self.loadData(from: productDetail)
        }).disposed(by: disposeBag)
        
        productDescription.asObservable().subscribe(onNext: { (productDescription) in
            self.productDescriptionLabel.text = productDescription.plainText
        }).disposed(by: disposeBag)
    }
    
    override func subscriptionData() {
        self.detailViewModel.responseProduct.subscribe(onNext: { (product) in
            self.productDetail.accept(product)
        }).disposed(by: disposeBag)
        
        self.detailViewModel.responseDescription.subscribe(onNext: { (description) in
            self.productDescription.accept(description)
        }).disposed(by: disposeBag)
    }
    

    private func loadData(from item: ProductDetailResponseModel) {
        productTitleLabel.text = item.title
        productPriceLabel.text = item.price!.toPriceString()

        imagesStackView.removeAllSubviews()
        item.pictures!.forEach({ pictureURL in
            let imageView = UIImageView()

            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: imagesScrollView.frame.size.height).isActive = true

            imageView.kf.setImage(with: pictureURL)

            imagesStackView.addArrangedSubview(imageView)
        })
    }

}
