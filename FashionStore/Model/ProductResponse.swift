//
//  ProductResponse.swift
//  FashionStore
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductResponse: Mappable {
    var products: [Product]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        products <- map["products"]
    }
}
