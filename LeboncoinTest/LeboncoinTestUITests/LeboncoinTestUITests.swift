//
//  LeboncoinTestUITests.swift
//  LeboncoinTestUITests
//
//  Created by CHEN on 08/07/2022.
//

import XCTest

class LeboncoinTestUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    // MARK: - Tests

    /*
     Make sure if app is displaying Dashboard's screen
     */
    func testDashboardView() {
        XCTAssertTrue(app.isDisplayingDashboardView)
    }
    
    func testProductSelectACategoryFilter() {
        XCTAssertTrue(app.isDisplayingDashboardView)
        XCTAssertTrue(app.collectionViews["CategoriesCollectionView"].exists)
        app.collectionViews["CategoriesCollectionView"].cells.element(boundBy:0).tap()
    }
    
    func testProductDetail() {
        XCTAssertTrue(app.isDisplayingDashboardView)
        XCTAssertTrue(app.collectionViews["ProductsCollectionView"].exists)
        app.collectionViews["ProductsCollectionView"].cells.element(boundBy: 0).tap()

        XCTAssertTrue(app.images["ProductDetailImageView"].exists)
    }
    
    func testAddProductToFavorite() {
        app.collectionViews["ProductsCollectionView"].cells.element(boundBy: 0).tap()
        
        XCTAssertTrue(app.images["ProductDetailFavoriteImageView"].exists)
        app.images["ProductDetailFavoriteImageView"].tap()
        
        app.buttons.element.tap()
        
        app.tabBars.element.tap()
        
    }
    
    func testProductDetailPhoto() {
        app.collectionViews["ProductsCollectionView"].cells.element(boundBy: 0).tap()
        
        app.images["ProductDetailImageView"].tap()
        XCTAssertTrue(app.isDisplayingProductDetailPhotoView)
    }
    
    /*
     Tap each element from TabBar
     and make sure if app is displaying FavoriteProducts' screen
     */
    func testFavoriteProductsView() {
        self.app.launch()
        self.app.tabBars.element.tap()
        
        // Make sure we're displaying FavoriteProducts
        XCTAssertTrue(app.isDisplayingFavoriteProductsView)
    }

    override func tearDownWithError() throws {
    }
}

extension XCUIApplication {
    var isDisplayingDashboardView: Bool {
        return otherElements["DashboardView"].exists
    }
    
    var isDisplayingFavoriteProductsView: Bool {
        return otherElements["FavoriteProductsView"].exists
    }
    
    var isDisplayingProductDetailView: Bool {
        return otherElements["ProductDetailView"].exists
    }
    
    var isDisplayingProductDetailPhotoView: Bool {
        return otherElements["ProductDetailPhotoView"].exists
    }
}
