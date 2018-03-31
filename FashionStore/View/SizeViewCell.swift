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
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = (oldValue) ? UIColor.black : UIColor.lightGray
        }
    }

    func configure(_ size:String) {
        self.layer.cornerRadius = CGFloat(kSizeCornerRadius)
        self.clipsToBounds = true
        
        sizeLabel.text = size
    }
}
