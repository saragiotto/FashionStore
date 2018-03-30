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
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with cellModel:ProductCellModel) {
        nameLabel.text = cellModel.name
        priceLabel.text = cellModel.regularPrice
        
        if (cellModel.onSale) {
            discountLabel.text = cellModel.discount
            priceLabel.text = cellModel.actualPrice
        }
        
        if let url = URL(string: cellModel.imageUrl) {
            imageView.kf.setImage(with: url,
                                  options:[.transition(.fade(0.3))])
        }
    }
}
