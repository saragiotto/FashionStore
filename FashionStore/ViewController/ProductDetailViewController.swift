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
    var productVM: ProductViewModel?
    
    var productIndexPath: IndexPath?
    private var sizeIndexPath:IndexPath?

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeCollection: UICollectionView!
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        sizeIndexPath = nil
        title = productModel?.name
        if let color = productModel?.color {
            colorLabel.text = "\(kColorLabelName): \(color)"
        }
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
            if (productModel?.sizes.count == 1) {
                self.sizeIndexPath = indexPath
                cell.backgroundColor = .black
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.sizeIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .black
        
        toogleSizeBorder(false)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let count = productModel?.sizes.count ?? 0
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        
        let totalCellWidth = kSizeCellWidth * Double(count)
        let totalSpacingWidth = kSizeCellSpacing * Double(count - 1)
        
        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        let topInset = (collectionViewHeight - CGFloat(kSizeCellWidth)) / 2
        let bottomInset = topInset
        
        return UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)
    }
    
    @IBAction func buyButtonClicked(_ sender: UIButton) {
        if self.sizeIndexPath == nil {
            self.toogleSizeBorder(true)
            return
        }
        
        if let productIP = self.productIndexPath, let sizeIP = self.sizeIndexPath {
            guard let product = productVM?.getProductModel(at: productIP) else {
                return
            }
            guard let size = productVM?.getAvailableSize(product, at: sizeIP) else {
                return
            }
            CartViewModel.shared.addProduct(product, of: size)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func toogleSizeBorder(_ show: Bool) {
        let indexPath = sizeCollection.indexPathsForVisibleItems
        let _ = indexPath.map({ index in
            if let cell = sizeCollection.cellForItem(at: index) as? SizeViewCell {
                if show {
                    cell.toggleBorderWarning()
                } else {
                    cell.layer.borderWidth = 0.0
                }
            }
        })
    }
}
