//
//  CartProduct.swift
//  FashionStore
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation

class ProductCart {
    var product: Product
    var size: ProductSize
    var color: String
    var count: Int
    
    required init?(_ product: Product, size: ProductSize, color: String, count: Int = 1) {
        self.product = product
        self.size = size
        self.color = color
        self.count = count
    }
}

extension ProductCart {
    static func ==(lhs: ProductCart, hrs: ProductCart) -> Bool {
        if let lhsSku = lhs.size.sku, let hrsSku = hrs.size.sku {
            return lhsSku == hrsSku
        }
        
        return false
    }
    
    static func !=(lhs: ProductCart, hrs: ProductCart) -> Bool {
        if let lhsSku = lhs.size.sku, let hrsSku = hrs.size.sku {
            return lhsSku != hrsSku
        }
        
        return false
    }
}
