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
    
    var borderToggle:Bool = false
    
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
        borderToggle = false
    }
    
    func toggleBorderWarning() {
        let borderWidth:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidth.fromValue = 0
        borderWidth.toValue = 2.0
        borderWidth.duration = 1.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.add(borderWidth, forKey: "Width")
        
//        self.layer.borderColor = UIColor.red.cgColor
//        self.layer.borderWidth = borderToggle ? 1.0 : 0.0
//
//        UIView.animate(withDuration: 0.5, animations: {
//            self.borderToggle = !self.borderToggle
//            self.layer.borderWidth = self.borderToggle ? 1.0 : 0.0
//        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        borderToggle = false
    }
}
