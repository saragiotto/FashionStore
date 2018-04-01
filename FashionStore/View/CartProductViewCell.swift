//
//  CartProductViewCell.swift
//  FashionStore
//
//  Created by Leonardo Saragiotto on 4/1/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import UIKit
import Kingfisher

class CartProductViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var count: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ cellModel:CartProductCellModel) {
        
        name.text = cellModel.name
        color.text = "\(kColorLabelName): \(cellModel.color)"
        size.text = "\(kSizeLabelName): \(cellModel.size)"
        price.text = cellModel.price
        count.text = cellModel.count
        
        if let url = URL(string: cellModel.imageUrl) {
            productImage.kf.setImage(with: url,
                                     options:[.transition(.fade(0.3))])
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productImage.kf.cancelDownloadTask()
        self.productImage.layer.removeAllAnimations()
        self.productImage.image = nil
    }
}
