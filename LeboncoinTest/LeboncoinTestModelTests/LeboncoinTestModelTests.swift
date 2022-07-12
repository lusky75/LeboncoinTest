//
//  LeboncoinTestModelTests.swift
//  LeboncoinTestModelTests
//
//  Created by CHEN on 08/07/2022.
//

import XCTest
@testable import LeboncoinTest

class LeboncoinTestModelTests: XCTestCase {
    
    var productModel: Product!
    var categoryModel: CategoryModel!
    var favoritesModel: Favorites!
    
    override func setUp() {
        for (key, _) in UserDefaults.standard.dictionaryRepresentation() {
            UserDefaults.standard.removeObject(forKey: key)
        }
        
        productModel = Product(id: 1461267313, category_id: 4, title: "title", description: "description", price: 140.0, creation_date: "2019-11-05T15:56:59+0000", is_urgent: false)
        categoryModel = CategoryModel(id: 1, name: "Véhicule")
        favoritesModel = Favorites()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testProductModel() {
        XCTAssertEqual(1461267313, productModel.id)
        XCTAssertEqual(4, productModel.category_id)
        XCTAssertEqual("title", productModel.title)
        XCTAssertEqual("description", productModel.description)
        XCTAssertEqual(140.0, productModel.price)
        XCTAssertEqual("2019-11-05T15:56:59+0000", productModel.creation_date)
        XCTAssertEqual(false, productModel.is_urgent)
    }
    
    func testCategoryModel() {
        XCTAssertEqual(1, categoryModel.id)
        XCTAssertEqual("Véhicule", categoryModel.name)
    }
    
    func testFavoriteModel() {
        let newProduct: Product = Product(id: 1461267313, category_id: 4, title: "title", description: "description", price: 140.0, creation_date: "2019-11-05T15:56:59+0000", is_urgent: false)
        
        favoritesModel.add(newProduct)
        favoritesModel.add(newProduct)
        
        XCTAssertEqual(1, favoritesModel.products.count)
        
        XCTAssertEqual(true, favoritesModel.contains(newProduct))
        
        favoritesModel.remove(newProduct)
        
        XCTAssertEqual(false, favoritesModel.contains(newProduct))
        
        XCTAssertEqual(0, favoritesModel.products.count)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
