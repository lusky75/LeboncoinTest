//
//  ProductDetailPhotoVC.swift
//  LeboncoinTest
//
//  Created by CHEN on 11/07/2022.
//

import UIKit

class ProductDetailPhotoVC: UIViewController {
    
    var coordinator: MainCoordinator?
    
    var productDetailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         accessibilityIdentifier is used for UI unit tests
        */
        view.accessibilityIdentifier = Constants.AccessibilityIdentifier.productDetailPhoto

        view.backgroundColor = .white
        // setup navigationBar title and image
        setupNavigationBarTitleAndImageContent()
        
        if let productDetail = coordinator?.productDetail {
            productDetailImageView.loadFrom(URLAddress: productDetail.images_url?.thumb ?? "")
            navigationItem.title = productDetail.title
        }
        
        view.addSubview(productDetailImageView)
        
        NSLayoutConstraint.activate([
            productDetailImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            productDetailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productDetailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupNavigationBarTitleAndImageContent() {
        
    }

}
