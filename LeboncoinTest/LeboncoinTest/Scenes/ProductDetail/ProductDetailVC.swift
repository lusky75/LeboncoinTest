//
//  ProductDetailVC.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    var productDetailView: ProductDetailView?
    
    var favorites: Favorites?

    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupProductDetailView()
        
        setupProductDetailContent()
    }
    
    override func viewDidLayoutSubviews() {
        productDetailView!.scrollView.contentSize = CGSize(width: view.frame.width, height: productDetailView!.productDetailDescriptionContentLabel.frame.origin.y + productDetailView!.productDetailDescriptionContentLabel.frame.height + Constants.ProductDetailView.scrollBottomSpacing)
    }
                                              
    /*
     Initiate dashboardView's frame and components and add as view's subview
     */
    func setupProductDetailView() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        productDetailView = ProductDetailView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
                
        view.addSubview(productDetailView!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(navigateToProductDetailPhotoAction))
        productDetailView!.productDetailImageView.isUserInteractionEnabled = true
        productDetailView!.productDetailImageView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapFavoriteGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addProductToFavoritesAction))
        productDetailView!.favoriteProductImageView.isUserInteractionEnabled = true
        productDetailView!.favoriteProductImageView.addGestureRecognizer(tapFavoriteGestureRecognizer)

        productDetailView?.backButton.addTarget(self, action: #selector(backToPreviousPage), for: .touchUpInside)
    }
    
    func setupProductDetailContent() {
        favorites = Favorites()
        
        if let productDetail = coordinator?.productDetail {
            let imageAddress = productDetail.images_url?.thumb
            productDetailView?.productDetailImageView.loadFrom(URLAddress: imageAddress ?? "")
            
            productDetailView?.productDetailTitleLabel.text = productDetail.title
            productDetailView?.productDetailPriceLabel.text = String(Int(productDetail.price)) + " €"
            //productDetailView?.productDetailCategoryLabel.text = "c"
            productDetailView?.productDetailDateLabel.text = Date().convertStringToDate(fromDate: productDetail.creation_date).displayDateFormat()
            productDetailView?.productDetailDescriptionContentLabel.text = productDetail.description
            
            checkIfFavoritesContainsProduct(product: productDetail)
        }
    }
    
    func checkIfFavoritesContainsProduct(product: Product) {
        if favorites!.products.contains(product) {
            productDetailView?.favoriteProductImageView.tintColor = .orange
        } else {
            productDetailView?.favoriteProductImageView.tintColor = .lightGray
        }
    }
    
    @objc func navigateToProductDetailPhotoAction() {
        coordinator?.navigateToProductDetailPhoto()
    }
    
    @objc func addProductToFavoritesAction() {
        if let productDetail = coordinator?.productDetail {
            if favorites!.contains(productDetail) {
                favorites?.remove(productDetail)
            } else {
                favorites?.add(productDetail)
            }
            checkIfFavoritesContainsProduct(product: productDetail)
        }
    }
    
    @objc func backToPreviousPage() {
        print("back to previous page")
        coordinator?.previousPage()
    }

}
