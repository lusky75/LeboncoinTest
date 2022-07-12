//
//  Constants.swift
//  LeboncoinTest
//
//  Created by CHEN on 11/07/2022.
//

import Foundation
import UIKit

struct Constants {
    struct ProductDetailView {
        static let scrollBottomSpacing: CGFloat = 50
    }
    
    struct AccessibilityIdentifier {
        static let dashboard = "DashboardView"
        static let favoriteProducts = "FavoriteProductsView"
        static let productDetail = "ProductDetailView"
        static let productDetailPhoto = "ProductDetailPhotoView"
        
        static let categoriesCollectionView = "CategoriesCollectionView"
        static let productsCollectionView = "ProductsCollectionView"
        
        struct ImageView {
            static let productDetail = "ProductDetailImageView"
            static let favorite = "ProductDetailFavoriteImageView"
        }
    }
}
