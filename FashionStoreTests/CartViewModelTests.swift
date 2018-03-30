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
    
    func testCartAmoutCheckWithOneItem() {
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
    
    func testCartAmoutCheckWithMultipleItens() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            if let product = productVM.products.first {
                let firstItem = CartProduct(product, size: product.sizes!.first!, color: product.color!)
                
                self.viewModel?.addItem(firstItem)
            } else {
                XCTAssert(false)
            }
            
            if let anotherProduct = productVM.products.last {
                let secondItem = CartProduct(anotherProduct, size: anotherProduct.sizes!.first!, color: anotherProduct.color!)
                
                self.viewModel?.addItem(secondItem)
            
                let totalCart = self.viewModel?.totalCart()
                XCTAssert(totalCart == "R$ 229,80")
            } else {
                XCTAssert(false)
            }
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartCheckItemCount() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            if let product = productVM.products.first {
                let cartItem = CartProduct(product, size: product.sizes!.first!, color: product.color!)
                
                self.viewModel?.addItem(cartItem)
                self.viewModel?.addItem(cartItem)
                
                let finalItem = self.viewModel?.cart.products?.first
                
                XCTAssert(finalItem?.count == 2)
                
            } else {
                XCTAssert(false)
            }
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckWithSameItens() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            if let product = productVM.products.first {
                let cartItem = CartProduct(product, size: product.sizes!.first!, color: product.color!)
                
                self.viewModel?.addItem(cartItem)
                self.viewModel?.addItem(cartItem)
                
                let totalCart = self.viewModel?.totalCart()
                XCTAssert(totalCart == "R$ 399,80")
                
            } else {
                XCTAssert(false)
            }
            
            exp.fulfill()
        }
        
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckRemovingItem() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            guard let product = productVM.products.first else {
                XCTAssert(false)
                return
            }
            guard let anotherProduct = productVM.products.last else {
                XCTAssert(false)
                return
            }
            
            let firstItem = CartProduct(product, size: product.sizes!.first!, color: product.color!)
            self.viewModel?.addItem(firstItem)
            let secondItem = CartProduct(anotherProduct, size: anotherProduct.sizes!.first!, color: anotherProduct.color!)
            self.viewModel?.addItem(secondItem)
            
            var totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart == "R$ 229,80")
            
            self.viewModel?.removeAllItens(firstItem)
            
            totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart == "R$ 29,90")
                
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckRemovingSameItem() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            if let product = productVM.products.first {
                let cartItem = CartProduct(product, size: product.sizes!.first!, color: product.color!)
                
                self.viewModel?.addItem(cartItem)
                self.viewModel?.addItem(cartItem)
                self.viewModel?.addItem(cartItem)
                
                var totalCart = self.viewModel?.totalCart()
                XCTAssert(totalCart == "R$ 599,70")
                
                self.viewModel?.removeItem(cartItem)
                self.viewModel?.removeItem(cartItem)
                
                totalCart = self.viewModel?.totalCart()
                XCTAssert(totalCart == "R$ 199,90")
            } else {
                XCTAssert(false)
            }
            
            exp.fulfill()
        }
        
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
