//
//  ProductDetailView.swift
//  LeboncoinTest
//
//  Created by CHEN on 11/07/2022.
//

import Foundation
import UIKit

class ProductDetailView: UIView {
    
    var backButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back_button_icon"), for: .normal)
        return button
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var favoriteProductImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "favorite_icon")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var productDetailImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "")
        imageView.clipsToBounds = true
        imageView.accessibilityIdentifier = Constants.AccessibilityIdentifier.ImageView.productDetail
        //imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var productDetailTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.setDemiBoldFont(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    var productDetailPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.setDemiBoldFont(size: 16)
        return label
    }()
    
    var productDetailCategoryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = UIFont.setAppFont(size: 14)
        return label
    }()
    
    var productDetailDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.setAppFont(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    var productDetailDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.textColor = .black
        label.font = UIFont.setDemiBoldFont(size: 18)
        return label
    }()
    
    var productDetailDescriptionContentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.setAppFont(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        scrollView.addSubview(productDetailImageView)
        
        scrollView.addSubview(favoriteProductImageView)
        scrollView.addSubview(productDetailTitleLabel)
        scrollView.addSubview(productDetailPriceLabel)
        scrollView.addSubview(productDetailCategoryLabel)
        
        scrollView.addSubview(productDetailDateLabel)
        
        scrollView.addSubview(productDetailDescriptionLabel)
        scrollView.addSubview(productDetailDescriptionContentLabel)
        
        self.addSubview(backButton)
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            productDetailImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productDetailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productDetailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productDetailImageView.heightAnchor.constraint(equalTo: productDetailImageView.widthAnchor),
            
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            favoriteProductImageView.centerYAnchor.constraint(equalTo: productDetailPriceLabel.centerYAnchor),
            favoriteProductImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            favoriteProductImageView.widthAnchor.constraint(equalToConstant: 30),
            
            productDetailTitleLabel.topAnchor.constraint(equalTo: productDetailImageView.bottomAnchor, constant: 20),
            productDetailTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            productDetailTitleLabel.trailingAnchor.constraint(equalTo: productDetailImageView.trailingAnchor, constant: -20),
            
            productDetailPriceLabel.topAnchor.constraint(equalTo: productDetailTitleLabel.bottomAnchor, constant: 10),
            productDetailPriceLabel.leadingAnchor.constraint(equalTo: productDetailTitleLabel.leadingAnchor),
            productDetailPriceLabel.trailingAnchor.constraint(equalTo: productDetailTitleLabel.trailingAnchor),
            
            productDetailCategoryLabel.topAnchor.constraint(equalTo: productDetailPriceLabel.bottomAnchor, constant: 10),
            productDetailCategoryLabel.leftAnchor.constraint(equalTo: productDetailTitleLabel.leftAnchor),
            
            productDetailDateLabel.topAnchor.constraint(equalTo: productDetailCategoryLabel.bottomAnchor, constant: 10),
            productDetailDateLabel.leadingAnchor.constraint(equalTo: productDetailTitleLabel.leadingAnchor),
            
            productDetailDescriptionLabel.topAnchor.constraint(equalTo: productDetailDateLabel.bottomAnchor, constant: 20),
            productDetailDescriptionLabel.leadingAnchor.constraint(equalTo: productDetailTitleLabel.leadingAnchor),
            
            productDetailDescriptionContentLabel.topAnchor.constraint(equalTo: productDetailDescriptionLabel.bottomAnchor, constant: 10),
            productDetailDescriptionContentLabel.leadingAnchor.constraint(equalTo: productDetailDescriptionLabel.leadingAnchor),
            productDetailDescriptionContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
