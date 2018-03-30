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
    
    var numberOfCells: Int {
        return products.count
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
    
    func getProductCell(at indexPath: IndexPath) -> ProductCellModel {
        
        let productModel = self.products[indexPath.row]
        
        return ProductCellModel(imageUrl: productModel.image ?? "",
                                discount: productModel.discountPercentage ?? "",
                                name: productModel.name ?? "",
                                onSale: productModel.onSale ?? false,
                                regularPrice: productModel.regularPrice ?? "",
                                actualPrice: productModel.actualPrice ?? "")
    }
}

struct ProductCellModel {
    let imageUrl: String
    let discount: String
    let name: String
    let onSale: Bool
    let regularPrice: String
    let actualPrice: String
}
