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
            guard let product = productVM.getProductModel(at: self.first) else {
                XCTAssert(false)
                return
            }
            guard let size = productVM.getAvailableSize(product, at: self.first) else {
                XCTAssert(false)
                return
            }
            
            self.viewModel?.addProduct(product, of: size)
            
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
            guard let product = productVM.getProductModel(at: self.first) else {
                XCTAssert(false)
                return
            }
            guard let size = productVM.getAvailableSize(product, at: self.first) else {
                XCTAssert(false)
                return
            }
            
            self.viewModel?.addProduct(product, of: size)
            let totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart == product.regularPrice ?? "")
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckWithMultipleItens() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            guard let product = productVM.getProductModel(at: self.first) else {
                XCTAssert(false)
                return
            }
            guard let size = productVM.getAvailableSize(product, at: self.first) else {
                XCTAssert(false)
                return
            }
            let last = IndexPath(row: productVM.numberOfCells - 1, section: 0)
            guard let anotherProduct = productVM.getProductModel(at: last) else {
                XCTAssert(false)
                return
            }
            guard let anotherSize = productVM.getAvailableSize(anotherProduct, at: self.first) else {
                XCTAssert(false)
                return
            }
            
            self.viewModel?.addProduct(product, of: size)
            self.viewModel?.addProduct(anotherProduct, of: anotherSize)
            
            let totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart == "R$ 229,80")
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartCheckItemCount() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            guard let product = productVM.getProductModel(at: self.first) else {
                XCTAssert(false)
                return
            }
            guard let size = productVM.getAvailableSize(product, at: self.first) else {
                XCTAssert(false)
                return
            }
            
            self.viewModel?.addProduct(product, of: size)
            self.viewModel?.addProduct(product, of: size)
            
            guard let finalItem = self.viewModel?.getCartItem(at: self.first) else {
                XCTAssert(false)
                return
            }
            
            XCTAssert(finalItem.count == 2)
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckWithSameItens() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            guard let product = productVM.getProductModel(at: self.first) else {
                XCTAssert(false)
                return
            }
            guard let size = productVM.getAvailableSize(product, at: self.first) else {
                XCTAssert(false)
                return
            }
            
            self.viewModel?.addProduct(product, of: size)
            self.viewModel?.addProduct(product, of: size)

            let totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart == "R$ 399,80")
            
            exp.fulfill()
        }
        
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckRemovingItem() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            guard let product = productVM.getProductModel(at: self.first) else {
                XCTAssert(false)
                return
            }
            guard let size = productVM.getAvailableSize(product, at: self.first) else {
                XCTAssert(false)
                return
            }
            let last = IndexPath(row: productVM.numberOfCells - 1, section: 0)
            guard let anotherProduct = productVM.getProductModel(at: last) else {
                XCTAssert(false)
                return
            }
            guard let anotherSize = productVM.getAvailableSize(anotherProduct, at: self.first) else {
                XCTAssert(false)
                return
            }
            
            self.viewModel?.addProduct(product, of: size)
            self.viewModel?.addProduct(anotherProduct, of: anotherSize)
            
            var totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart == "R$ 229,80")
            
            self.viewModel?.removeAllItens(at: self.first)
            
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
            guard let product = productVM.getProductModel(at: self.first) else {
                XCTAssert(false)
                return
            }
            guard let size = productVM.getAvailableSize(product, at: self.first) else {
                XCTAssert(false)
                return
            }
            
            self.viewModel?.addProduct(product, of: size)
            self.viewModel?.addProduct(product, of: size)
            self.viewModel?.addProduct(product, of: size)
            
            var totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart == "R$ 599,70")
            
            self.viewModel?.removeItem(at: self.first)
            self.viewModel?.removeItem(at: self.first)
            
            totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart == "R$ 199,90")
            
            exp.fulfill()
        }
        
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCartAmoutCheckForEmptyState() {
        let exp = expectation(description: "\(#function)\(#line)")
        let productVM = ProductViewModel()
        
        productVM.didFinishFetchClosure = {
            guard let product = productVM.getProductModel(at: self.first) else {
                XCTAssert(false)
                return
            }
            guard let size = productVM.getAvailableSize(product, at: self.first) else {
                XCTAssert(false)
                return
            }
            
            self.viewModel?.addProduct(product, of: size)
            self.viewModel?.removeAllItens(at: self.first)
            
            let totalCart = self.viewModel?.totalCart()
            XCTAssert(totalCart == "R$ 0,00")
            
            exp.fulfill()
        }
        productVM.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
