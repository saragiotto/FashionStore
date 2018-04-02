//
//  ProductViewCell.swift
//  FashionStore
//
//  Created by Leonardo Saragiotto on 3/30/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import UIKit
import Kingfisher

class ProductViewCell: UICollectionViewCell {

    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var discountLabel: EdgeInsetLabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with cellModel:ProductCellModel) {
        nameLabel.text = cellModel.name
        priceLabel.text = cellModel.price
        
        if let attrPrice = cellModel.attributedPrice {
            priceLabel.attributedText = attrPrice
        }
        
        if (cellModel.onSale) {
            discountLabel.layer.cornerRadius = CGFloat(kDiscountCornerRadius)
            discountLabel.clipsToBounds = true
            discountLabel.text = "\(cellModel.discount) off"
        } else {
            discountLabel.text = ""
        }
        
        productView.layer.cornerRadius = CGFloat(kDiscountCornerRadius)
        productView.clipsToBounds = true
        productView.layer.borderColor = UIColor.lightGray.cgColor
        productView.layer.borderWidth = 0.5
        
        if let url = URL(string: cellModel.imageUrl) {
            imageView.contentMode = .scaleAspectFill
            imageView.kf.setImage(with: url,
                                  options:[.transition(.fade(0.3))])
        } else {
            imageView.contentMode = .center
            imageView.image = UIImage(named: kProductNoImageName)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.kf.cancelDownloadTask()
        self.imageView.layer.removeAllAnimations()
        self.imageView.image = nil
    }
}
