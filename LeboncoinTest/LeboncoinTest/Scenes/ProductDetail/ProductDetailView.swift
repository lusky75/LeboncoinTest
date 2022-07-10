//
//  ProductDetailView.swift
//  LeboncoinTest
//
//  Created by CHEN on 11/07/2022.
//

import Foundation
import UIKit

class ProductDetailView: UIView {
    
    var productDetailImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "")
        imageView.clipsToBounds = true
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
        label.font = UIFont.setDemiBoldFont(size: 13)
        return label
    }()
    
    var productDetailCategoryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.setAppFont(size: 12)
        return label
    }()
    
    var productDetailDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.setAppFont(size: 12)
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
        label.font = UIFont.setAppFont(size: 12)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(productDetailImageView)
        addSubview(productDetailTitleLabel)
        addSubview(productDetailPriceLabel)
        addSubview(productDetailCategoryLabel)
        
        addSubview(productDetailDateLabel)
        
        addSubview(productDetailDescriptionLabel)
        addSubview(productDetailDescriptionContentLabel)
                
        NSLayoutConstraint.activate([
            productDetailImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productDetailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productDetailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productDetailImageView.heightAnchor.constraint(equalTo: productDetailImageView.widthAnchor),
            
            productDetailTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            productDetailTitleLabel.topAnchor.constraint(equalTo: productDetailImageView.bottomAnchor, constant: 10),
            productDetailTitleLabel.rightAnchor.constraint(equalTo: productDetailImageView.rightAnchor),
            
            productDetailPriceLabel.topAnchor.constraint(equalTo: productDetailTitleLabel.bottomAnchor, constant: 5),
            productDetailPriceLabel.leftAnchor.constraint(equalTo: productDetailTitleLabel.leftAnchor),
            productDetailPriceLabel.rightAnchor.constraint(equalTo: productDetailTitleLabel.rightAnchor),
            //productPriceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            
            productDetailCategoryLabel.topAnchor.constraint(equalTo: productDetailPriceLabel.bottomAnchor, constant: 5),
            productDetailCategoryLabel.leftAnchor.constraint(equalTo: productDetailTitleLabel.leftAnchor),
            
            productDetailDateLabel.topAnchor.constraint(equalTo: productDetailCategoryLabel.bottomAnchor, constant: 10),
            productDetailDateLabel.leftAnchor.constraint(equalTo: productDetailTitleLabel.leftAnchor),
            
            productDetailDescriptionLabel.topAnchor.constraint(equalTo: productDetailDateLabel.bottomAnchor, constant: 10),
            productDetailDescriptionLabel.leftAnchor.constraint(equalTo: productDetailTitleLabel.leftAnchor),
            
            productDetailDescriptionContentLabel.topAnchor.constraint(equalTo: productDetailDescriptionLabel.bottomAnchor, constant: 10),
            productDetailDescriptionContentLabel.leftAnchor.constraint(equalTo: productDetailDescriptionLabel.leftAnchor),
            productDetailDescriptionContentLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
