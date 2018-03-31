//
//  ProductSize.swift
//  FashionStore
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductSize: Mappable {
    
    var available: Bool?
    var size: String?
    var sku: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        available <- map["available"]
        size <- map["size"]
        sku <- map["sku"]
    }
}
