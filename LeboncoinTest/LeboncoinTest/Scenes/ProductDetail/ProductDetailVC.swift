//
//  ProductDetailVC.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    var productDetailView: ProductDetailView?

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
        productDetailView = ProductDetailView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
                
        view.addSubview(productDetailView!)
        
        let tapGestureRecongizer = UITapGestureRecognizer(target: self, action: #selector(navigateToProductDetailPhotoAction))
        productDetailView!.productDetailImageView.isUserInteractionEnabled = true
        productDetailView!.productDetailImageView.addGestureRecognizer(tapGestureRecongizer)

    }
    
    func setupProductDetailContent() {
        if let productDetail = coordinator?.productDetail {
            let imageAddress = productDetail.images_url?.thumb
            productDetailView?.productDetailImageView.loadFrom(URLAddress: imageAddress ?? "")
            
            productDetailView?.productDetailTitleLabel.text = productDetail.title
            productDetailView?.productDetailPriceLabel.text = String(Int(productDetail.price)) + " €"
            //productDetailView?.productDetailCategoryLabel.text = "c"
            productDetailView?.productDetailDateLabel.text = Date().convertStringToDate(fromDate: productDetail.creation_date).displayDateFormat()
            productDetailView?.productDetailDescriptionContentLabel.text = productDetail.description
        }
    }
    
    @objc func navigateToProductDetailPhotoAction() {
        coordinator?.navigateToProductDetailPhoto()
    }

}
