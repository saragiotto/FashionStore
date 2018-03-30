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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureViewModel()
    }
    
    private func configureView() {
        self.clearsSelectionOnViewWillAppear = true
        
        let productCellNib = UINib.init(nibName: "ProductViewCell", bundle: nil)
        self.collectionView?.register(productCellNib, forCellWithReuseIdentifier: kProductCellIdentifier)
    }
    
    private func configureViewModel() {
        productVM.didFinishFetchClosure = {
            self.collectionView?.reloadData()
        }
        productVM.fetchProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

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
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let itemWidth = screenWidth/2 - 1
        let itemHeight = (itemWidth/3) * 5
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
