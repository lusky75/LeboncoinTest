//
//  HomeViewModel.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published public var categoryList: [Category]?
    @Published public var productList: [Product]?
    @Published var selectedCategory: [Category] = []
    
    private let homeService: HomeServiceProtocol
    
    // MARK: - Variables
    
    var title: String {
        "Liste des produits"
    }
    
    /**
     We also add the cancellables property to store future subscriptions
    */
    private var cancellables = Set<AnyCancellable>()
    
    init(homeService: HomeServiceProtocol = HomeService()) {
        self.homeService = homeService
    }
    
    public func onAppear() {
        getCategories()
    }
    
    private func getCategories() {
        homeService.getCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    Log.error(error)
                case .finished: break
                }
            }, receiveValue: { response in
                self.categoryList = response
                
                self.getListing()
            })
            .store(in: &cancellables)
    }
    
    func getListing() {
        homeService.getListing()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    Log.error(error)
                    
                    self.productList = MockModel.getListing
                case .finished: break
                }
            }, receiveValue: { listing in
                var productList: [Product] = []
                for item in listing {
                    guard let category = self.getCategory(categoryId: item.categoryId) else { continue }
                    var product = item
                    product.updateCategory(category: category)
                    productList.append(product)
                }
                productList.sort(by: { $0.isUrgent && !$1.isUrgent })
                self.productList = productList
                
                if !self.selectedCategory.isEmpty {
                    self.filterProductsBySelectedCategory()
                }
            })
            .store(in: &cancellables)
    }
    
    private func filterProductsBySelectedCategory() {
        guard let productList = productList,
              let categoryList = categoryList,
              !categoryList.isEmpty else {
            return
        }
        self.productList?.removeAll()
        var filteredProductList: [Product] = []
        var productIsInCategory: Bool = false
    
        for product in productList {
            productIsInCategory = false
            for index in categoryList.indices {
                if product.categoryId == categoryList[index].id && selectedCategory.contains(categoryList[index]) {
                    productIsInCategory = true
                }
            }
            if productIsInCategory == true {
                filteredProductList.append(product)
            }
        }
        self.productList = filteredProductList
    }
    
    private func getCategory(categoryId: Int) -> String? {
        guard let categoryName = categoryList?.first(where: { $0.id == categoryId })?.name else {
            return nil
        }
        return categoryName
    }
}
