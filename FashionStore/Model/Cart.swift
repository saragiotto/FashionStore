//
//  Cart.swift
//  FashionStore
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation

class Cart {
    var products: [CartProduct]?
    var discountCupom: String?
    var zipCode: String?
    var totalPrice: String?
 
    init() {
        products = [CartProduct]()
    }
}
