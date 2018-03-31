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
        var attrPrice: NSAttributedString?
        
        if (productModel.onSale ?? false) {
            attrPrice = attributedString(productModel)
        }
        
        return ProductCellModel(imageUrl: productModel.image ?? "",
                                discount: productModel.discountPercentage ?? "",
                                name: productModel.name?.capitalized ?? "",
                                price: productModel.regularPrice ?? "",
                                onSale: productModel.onSale ?? false,
                                attributedPrice: attrPrice)
    }
    
    private func attributedString(_ product:Product) -> NSAttributedString {
        let priceString = "\(product.regularPrice ?? "") \(product.actualPrice ?? "")"
        let attrString = NSMutableAttributedString(string: priceString)
        attrString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, (product.regularPrice ?? "").count))
        
        return attrString
    }
    
    func getProductDetail(at indexPath:IndexPath) -> ProductDetailModel {
        let productModel = self.products[indexPath.row]
        let availableSizes = productModel.sizes?.filter({ size in
            return (size.available ?? false)
        })
        
        var sizes: [String]?
        
        if let available = availableSizes {
            sizes = available.map({$0.size ?? ""})
        }
        
        var price = productModel.regularPrice
        
        if (productModel.onSale ?? false) {
            price = productModel.actualPrice
        }
        
        return ProductDetailModel(imageUrl: productModel.image ?? "",
                                  name: productModel.name?.capitalized ?? "",
                                  color: productModel.color?.capitalized ?? "",
                                  price: price ?? "",
                                  sizes: sizes ?? [])
    }
}

struct ProductCellModel {
    let imageUrl: String
    let discount: String
    let name: String
    let price: String
    let onSale: Bool
    let attributedPrice: NSAttributedString?
}

struct ProductDetailModel {
    let imageUrl: String
    let name: String
    let color: String
    let price: String
    let sizes: [String]
}

