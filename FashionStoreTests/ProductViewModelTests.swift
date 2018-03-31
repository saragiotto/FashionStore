//
//  FashionStoreTests.swift
//  FashionStoreTests
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import XCTest
@testable import FashionStore

class ProdutcViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchProducts() {
        let exp = expectation(description: "\(#function)\(#line)")
        let viewModel = ProductViewModel()
        
        viewModel.didFinishFetchClosure = {
            XCTAssert(viewModel.numberOfCells > 0)
            exp.fulfill()
        }
        
        viewModel.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testProductsCount() {
        let exp = expectation(description: "\(#function)\(#line)")
        let viewModel = ProductViewModel()
        
        viewModel.didFinishFetchClosure = {
            XCTAssert(viewModel.numberOfCells == 22)
            exp.fulfill()
        }
        
        viewModel.fetchProducts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testProductsOnSaleCount() {
        let exp = expectation(description: "\(#function)\(#line)")
        let viewModel = ProductViewModel()
        
        viewModel.didFinishFetchClosure = {
            XCTAssert(viewModel.numberOfCells == 8)
            exp.fulfill()
        }
        
        viewModel.fetchProducts(onSale: true)
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
