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
        nameLabel.text = cellModel.name.capitalized
        priceLabel.text = cellModel.regularPrice
        
        if (cellModel.onSale) {
            discountLabel.layer.cornerRadius = 5.0
            discountLabel.clipsToBounds = true
            discountLabel.text = "\(cellModel.discount) off"
            
            priceLabel.text = cellModel.actualPrice
        } else {
            discountLabel.text = ""
        }
        
        productView.layer.cornerRadius = 5.0
        productView.clipsToBounds = true
        
        if let url = URL(string: cellModel.imageUrl) {
            imageView.kf.setImage(with: url,
                                  options:[.transition(.fade(0.3))])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.kf.cancelDownloadTask()
        self.imageView.layer.removeAllAnimations()
        self.imageView.image = nil
    }
}
