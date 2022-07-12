//
//  LeboncoinTestViewModelTests.swift
//  LeboncoinTestTests
//
//  Created by CHEN on 12/07/2022.
//

import XCTest
@testable import LeboncoinTest

class LeboncoinTestViewModelTests: XCTestCase {
    
    var productsViewModel: ProductsViewModel?

    override func setUpWithError() throws {
        productsViewModel = ProductsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testProductViewModel() {
        let firstProduct: Product = Product(id: 1691247255, category_id: 4, title: "title2", description: "description2", price: 140.0, creation_date: "2019-10-16T17:10:20+0000", is_urgent: false)
        let secondProduct: Product = Product(id: 1461267313, category_id: 8, title: "title", description: "description", price: 140.0, creation_date: "2019-11-05T15:56:59+0000", is_urgent: false)
        
        let newCategoryModel: CategoryModel = CategoryModel(id: 4, name: "Maison")
        productsViewModel?.listOfProducts.append(firstProduct)
        productsViewModel?.listOfProducts.append(secondProduct)
        
        XCTAssertEqual(2, productsViewModel?.listOfProducts.count)
        
        productsViewModel?.listOfCategories.append(newCategoryModel)
        productsViewModel?.sortListOfProductsByDate {
            if let firstProduct = productsViewModel?.listOfProducts.first, let lastProduct = productsViewModel?.listOfProducts.last {
                XCTAssert(firstProduct.creation_datetime! > lastProduct.creation_datetime!)
            }
        }
        XCTAssertEqual("Maison", productsViewModel?.searchCategory(category_id: firstProduct.category_id))
    }

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
