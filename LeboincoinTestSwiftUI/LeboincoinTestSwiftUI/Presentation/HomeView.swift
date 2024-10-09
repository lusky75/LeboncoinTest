//
//  HomeView.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    private let productColumnGrid = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 20) {
                titleView
                
                categoryListScrollView
                
                productGridScrollView
            }
        }
        .onAppear(perform: onAppear)
    }
    
    private var titleView: some View {
        Text(viewModel.title)
            .foregroundColor(.blackColor)
            .font(Font.custom(.helveticaNeue75, size: 30))
            .padding(.top, .homeTitlePaddingTop)
            .padding(.leading, .homeTitlePaddingLeading)
    }
    
    @ViewBuilder
    private var categoryListScrollView: some View {
        if let categoryList = viewModel.categoryList {
            ScrollView(.horizontal) {
                HStack(spacing: .homeCategoryViewSpacing) {
                    ForEach(categoryList, id: \.id) { category in
                        HomeCategoryView(title: category.name, selected: self.viewModel.selectedCategory.contains(category))
                            .onTapGesture {
                                if self.viewModel.selectedCategory.contains(category) {
                                    self.viewModel.selectedCategory.removeAll(where: { $0 == category })
                                } else {
                                    self.viewModel.selectedCategory.append(category)
                                }
                                self.viewModel.getListing()
                            }
                    }
                }
                .padding(.vertical, 10)
            }
            .padding(.leading, .homeTitlePaddingLeading)
        }
    }
    
    @ViewBuilder
    private var productGridScrollView: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                productGridView
                    .padding(.leading, 30)
            }
        }
    }
    
    @ViewBuilder
    private var productGridView: some View {
        if let productList = viewModel.productList {
                LazyVGrid(columns: productColumnGrid, alignment: .leading, spacing: 20, pinnedViews: [], content: {
                    ForEach(productList, id: \.self) { product in
                        NavigationLink {
                            Navigation.destinationForEntrypoint("/" + Navigation.Deeplink.Name.page.rawValue + "/" +  product.title)
                        } label: {
                            ProductRowCard(viewModel: ProductRowCardViewModel(model: product))
                        }
                    }
                })
                .padding(.top, 10)
        }
    }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

extension HomeView {
    private func onAppear() {
        viewModel.onAppear()
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
