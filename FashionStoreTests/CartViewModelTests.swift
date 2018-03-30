//
//  CartViewModelTests.swift
//  FashionStoreTests
//
//  Created by Leonardo Saragiotto on 3/29/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import XCTest
@testable import FashionStore

class CartViewModelTests: XCTestCase {
    
    var viewModel: CartViewModel?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CartViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPutFirstItemToCart() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            if let product = productVM.products.first {
                let cartItem = CartProduct(product, size: product.sizes!.first!, color: product.color!)
                
                self.viewModel?.addItem(cartItem)
                XCTAssert((self.viewModel?.cartItens ?? 0) > 0)
            
            } else {
                XCTAssert(false)
            }
            
            
            exp.fulfill()
        }
        
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheck() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            if let product = productVM.products.first {
                let cartItem = CartProduct(product, size: product.sizes!.first!, color: product.color!)
                
                self.viewModel?.addItem(cartItem)
                let totalCart = self.viewModel?.totalCart()
                
                XCTAssert(totalCart == product.actualPrice!)
                
            } else {
                XCTAssert(false)
            }
            
            
            exp.fulfill()
        }
        
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
