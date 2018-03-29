//
//  Product.swift
//  FashionStore
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: Mappable {
    
    var name: String?
    var style: String?
    var codeColor: String?
    var colorSlug: String?
    var color: String?
    var onSale: Bool?
    var regularPrice: String?
    var actualPrice: String?
    var discountPercentage: String?
    var installments: String?
    var image: String?
    var sizes: [ProductSize]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        style <- map["style"]
        codeColor <- map["code_color"]
        colorSlug <- map["color_slug"]
        color <- map["color"]
        onSale <- map["on_sale"]
        regularPrice <- map["regular_price"]
        actualPrice <- map["actual_price"]
        discountPercentage <- map["discount_percentage"]
        installments <- map["installments"]
        image <- map["image"]
        sizes <- map["sizes"]
    }

}
