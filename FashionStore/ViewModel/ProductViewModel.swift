//
//  ProductViewModel.swift
//  FashionStore
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ProductViewModel {
    var products: [Product] {
        didSet {
            self.didFinishFetchClosure?()
        }
    }
    
    var didFinishFetchClosure: (() -> ())?
    
    private var page: Int
    
    init() {
        self.products = [Product]()
        self.page = 1
    }
    
    func fetchProducts() {
        
        Alamofire.request(kFashionUrl).responseObject { (response: DataResponse<ProductResponse>) in
            
            switch response.result {
            case .success(let result):
                if let products = result.products {
                    self.products += products
                }
                self.page += 1
                break
            case .failure:
                print("Error requesting shots")
                break
            }
        }
    }
}
