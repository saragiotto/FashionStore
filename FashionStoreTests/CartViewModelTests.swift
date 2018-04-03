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
    let first = IndexPath(row: 0, section: 0)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CartViewModel.shared
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel?.resetCart()
        super.tearDown()
    }
    
    func testPutFirstItemToCart() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            
            XCTAssert((self.viewModel?.cartItens ?? 0) > 0)
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckWithOneItem() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            
            let totalCart = self.viewModel?.totalCart()
            XCTAssert((totalCart ?? 0.0) == 199.90)
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckWithMultipleItens() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            
            let last = IndexPath(row: productVM.numberOfCells - 1, section: 0)
            productVM.addToCartProduct(at: last, sizeAt: self.first)
            
            let totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart ?? 0.0 == 229.80)
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartCheckItemCount() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            
            guard let finalItem = self.viewModel?.getCartProduct(at: self.first) else {
                XCTAssert(false)
                return
            }
            
            XCTAssert(finalItem.count == String(2))
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckWithSameItens() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)

            let totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart ?? 0.0 == 399.80)
            
            exp.fulfill()
        }
        
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckRemovingItem() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            
            let last = IndexPath(row: productVM.numberOfCells - 1, section: 0)
            productVM.addToCartProduct(at: last, sizeAt: self.first)
            
            var totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart ?? 0.0 == 229.80)
            
            self.viewModel?.removeAllItens(at: self.first)
            
            totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart ?? 0.0 == 29.90)
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckRemovingSameItem() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            
            var totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart ?? 0.0 == 599.70)
            
            self.viewModel?.removeItem(at: self.first)
            self.viewModel?.removeItem(at: self.first)
            
            totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart ?? 0.0 == 199.90)
            
            exp.fulfill()
        }
        
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckForEmptyState() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            
            self.viewModel?.removeAllItens(at: self.first)
            
            let totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart ?? 0.0 == 0.0)
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testOnSaleProducts() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            productVM.addToCartProduct(at: self.first, sizeAt: self.first)
            
            let totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart ?? 0.0 == 119.90)
            
            exp.fulfill()
        }
        productVM.fetchProducts(onSale: true)
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
