//
//  productCell.swift
//  meli-mobile-challenge
//
//  Created by Ernesto Colmenarez on 19/11/20.
//

import Foundation
import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = R.color.blackMeli2()
        priceLabel.textColor = R.color.blackMeli1()
    }
    
    public func configure(with item: SearchItemModel) {
        productImage.kf.setImage(with: item.thumbnail)
        titleLabel.text = item.title
        priceLabel.text = item.price!.toPriceString()
    }
    
}
