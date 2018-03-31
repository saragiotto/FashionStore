//
//  ProductDetailViewController.swift
//  FashionStore
//
//  Created by Leonardo Saragiotto on 3/30/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    var productModel: ProductDetailModel?

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeCollection: UICollectionView!
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = productModel?.name
        colorLabel.text = productModel?.color
        
        if let imageUrl = productModel?.imageUrl, let url = URL(string: imageUrl) {
            productImage.kf.setImage(with: url,
                                     options:[.transition(.fade(0.3))])
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
