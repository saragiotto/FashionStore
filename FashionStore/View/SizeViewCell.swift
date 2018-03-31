//
//  SizeViewCell.swift
//  FashionStore
//
//  Created by Leonardo Saragiotto on 3/31/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import UIKit

class SizeViewCell: UICollectionViewCell {

    @IBOutlet weak var sizeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ size:String) {
        self.contentView.layer.cornerRadius = CGFloat(kSizeCornerRadius)
        self.contentView.clipsToBounds = true
        
        sizeLabel.text = size
    }
}
