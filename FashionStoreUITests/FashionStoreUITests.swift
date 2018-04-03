//
//  FashionStoreUITests.swift
//  FashionStoreUITests
//
//  Created by Leonardo Augusto N Saragiotto on 02/04/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import XCTest
@testable import FashionStore

class FashionStoreUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPriceForRegularItem() {
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.cells.element(boundBy:0).tap()
        
        let priceLabel = app.staticTexts["priceLabel"]
        XCTAssertEqual(priceLabel.label, "R$ 199,90")
    }
    
    func testAddItemToCart() {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.element(boundBy:0).tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["P"]/*[[".cells.staticTexts[\"P\"]",".staticTexts[\"P\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Comprar"].tap()
        
        let shippingLabel = app.staticTexts["shippingLabel"]
        XCTAssertEqual(shippingLabel.label, "R$ 12,20")
        
        let priceLabel = app.staticTexts["totalLabel"]
        XCTAssertEqual(priceLabel.label, "R$ 212,10")
    }
    
    func testFilterOnSale() {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Promoções"]/*[[".segmentedControls.buttons[\"Promoções\"]",".buttons[\"Promoções\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"Bolsa Flap Triangle").children(matching: .other).element.tap()
        
        let discountLabel = app.staticTexts["discountLabel"]
        XCTAssertEqual(discountLabel.label, "25% off")
    }
    
    func testEmptyCart() {
        let app = XCUIApplication()
        app.launch()
    
        app.navigationBars["AMARO"].buttons["Item"].tap()
        
        let priceLabel = app.staticTexts["totalLabel"]
        XCTAssertEqual(priceLabel.label, "R$ 0,00")
    }
    
    func testAddCartItem() {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.element(boundBy:0).tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["G"]/*[[".cells.staticTexts[\"G\"]",".staticTexts[\"G\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Comprar"].tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let priceLabel = app.staticTexts["totalLabel"]
        XCTAssertEqual(priceLabel.label, "R$ 413,00")
    }
    
    func testDeleteCartItem() {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.element(boundBy:0).tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["M"]/*[[".cells.staticTexts[\"M\"]",".staticTexts[\"M\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Comprar"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Tamanho: M"]/*[[".cells.staticTexts[\"Tamanho: M\"]",".staticTexts[\"Tamanho: M\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        app.buttons["Excluir"].tap()
        
        let priceLabel = app.staticTexts["totalLabel"]
        XCTAssertEqual(priceLabel.label, "R$ 0,00")
        app.navigationBars["Sacola"].buttons["Item"].tap()
        
    }
    
    func testFinishCart() {
        let app = XCUIApplication()
        app.launch()
    
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.element(boundBy:0).tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["G"]/*[[".cells.staticTexts[\"G\"]",".staticTexts[\"G\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
        app.buttons["Comprar"].tap()
        app.buttons["Finalizar Compra"].tap()
        app.buttons["Ok"].tap()
        
        let priceLabel = app.staticTexts["totalLabel"]
        XCTAssertEqual(priceLabel.label, "R$ 0,00")
    }
}
