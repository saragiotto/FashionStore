//
//  ProductViewController.swift
//  FashionStore
//
//  Created by Leonardo Saragiotto on 3/30/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import UIKit

class ProductViewController: UICollectionViewController {
    
    var productVM = ProductViewModel()
    private var onSaleFilter = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.configureView()
        self.configureViewModel()
    }
    
    private func configureView() {
        self.clearsSelectionOnViewWillAppear = true
        self.title = kNavigationTitle
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let productCellNib = UINib.init(nibName: "ProductViewCell", bundle: nil)
        self.collectionView?.register(productCellNib, forCellWithReuseIdentifier: kProductCellIdentifier)
        
        let name = NSNotification.Name(kFilterNotification)
        NotificationCenter.default.addObserver(self, selector: #selector(segmentedDidChange), name: name, object: nil)
    }
    
    private func configureViewModel(onSale:Bool = false) {
        productVM.didFinishFetchClosure = {
            self.collectionView?.reloadData()
        }
        productVM.fetchProducts(onSale: onSale)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == kProductDetailSegue {
            if let destinationVC = segue.destination as? ProductDetailViewController {
                guard let indexPath = collectionView?.indexPathsForSelectedItems?.first else { return }
                destinationVC.productModel = productVM.getProductDetail(at: indexPath)
                destinationVC.productIndexPath = indexPath
                destinationVC.productVM = productVM
            }
        }
    }
    
    @objc func segmentedDidChange(_ notification: Notification) {
        
        guard let object = notification.object as? [String:Int] else { return }
        
        if object[kSegmentedIndex] == 0 {
            self.onSaleFilter = false
        } else {
            self.onSaleFilter = true
        }
        
        productVM = ProductViewModel()
        self.configureViewModel(onSale: self.onSaleFilter)        
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productVM.numberOfCells
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kProductCellIdentifier, for: indexPath) as? ProductViewCell {
            cell.configure(with: productVM.getProductCell(at: indexPath))
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kProductDetailSegue, sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewIdentifier, for: indexPath) as? ProductHeaderReusableView {
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let itemWidth = screenWidth/2 - 1
        let itemHeight = (itemWidth/3) * 4.5
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
