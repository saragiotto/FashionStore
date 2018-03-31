//
//  ProductDetailViewController.swift
//  FashionStore
//
//  Created by Leonardo Saragiotto on 3/30/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var productModel: ProductDetailModel?
    var selectedIndexPath: IndexPath?
    var productVM: ProductViewModel?

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeCollection: UICollectionView!
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = productModel?.name
        colorLabel.text = productModel?.color
        priceLabel.text = productModel?.price
        
        sizeCollection.delegate = self
        sizeCollection.dataSource = self

        let sizeCellNib = UINib.init(nibName: "SizeViewCell", bundle: nil)
        sizeCollection.register(sizeCellNib, forCellWithReuseIdentifier: kSizeCellIdentifier)
        
        if let imageUrl = productModel?.imageUrl, let url = URL(string: imageUrl) {
            productImage.kf.setImage(with: url,
                                     options:[.transition(.fade(0.3))])
        }
        
        buyButton.layer.cornerRadius = CGFloat(kDiscountCornerRadius)
        buyButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productModel?.sizes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSizeCellIdentifier, for: indexPath) as? SizeViewCell {
        
            cell.configure(productModel?.sizes[indexPath.row] ?? "")
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .black
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let count = productModel?.sizes.count ?? 0
        let collectionViewWidth = collectionView.bounds.width
        
        let totalCellWidth = kSizeCellWidth * Double(count)
        let totalSpacingWidth = kSizeCellSpacing * Double(count - 1)
        
        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }
    
    @IBAction func buyButtonClicked(_ sender: UIButton) {
        let indexPath = sizeCollection.indexPathsForVisibleItems
        let _ = indexPath.map({ index in
            if let cell = sizeCollection.cellForItem(at: index) as? SizeViewCell {
                cell.toggleBorderWarning()
            }
        })
    }
}
