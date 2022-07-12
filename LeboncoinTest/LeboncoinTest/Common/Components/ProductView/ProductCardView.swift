//
//  ProductCardView.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import Foundation
import UIKit

class ProductCardView: UIView {
    
    var productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        //imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var productTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.setDemiBoldFont(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var productPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.setDemiBoldFont(size: 14)
        return label
    }()
    
    var productCategoryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.setAppFont(size: 14)
        return label
    }()
    
    var urgentProductView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.orange.withAlphaComponent(0.15)
        view.isHidden = true
        return view
    }()
    
    var urgentProductLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vente urgente"
        label.textColor = .orange
        label.numberOfLines = 0
        label.font = UIFont.setAppFont(size: 11)
        return label
    }()

    override func layoutSubviews() {
        
        setupViews()
        
        setupViewsConstraints()
    }
    
    func setupViews() {
        addSubview(productImageView)
        addSubview(productTitleLabel)
        addSubview(productPriceLabel)
        addSubview(productCategoryLabel)
        
        addSubview(urgentProductView)
        urgentProductView.addSubview(urgentProductLabel)
    }
    
    func setupViewsConstraints() {
        NSLayoutConstraint.activate([
            
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            productImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            productImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor, multiplier: 1.1),
            
            productTitleLabel.leftAnchor.constraint(equalTo: productImageView.leftAnchor),
            productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productTitleLabel.rightAnchor.constraint(equalTo: productImageView.rightAnchor),
            
            productPriceLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 5),
            productPriceLabel.leftAnchor.constraint(equalTo: productTitleLabel.leftAnchor),
            productPriceLabel.rightAnchor.constraint(equalTo: productTitleLabel.rightAnchor),
            //productPriceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            
            productCategoryLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 5),
            productCategoryLabel.leftAnchor.constraint(equalTo: productTitleLabel.leftAnchor),
            
            urgentProductView.topAnchor.constraint(equalTo: productCategoryLabel.bottomAnchor, constant: 5),
            urgentProductView.leftAnchor.constraint(equalTo: productTitleLabel.leftAnchor),
            urgentProductView.heightAnchor.constraint(equalToConstant: 20),
            
            urgentProductLabel.leftAnchor.constraint(equalTo: urgentProductView.leftAnchor, constant: 10),
            urgentProductLabel.rightAnchor.constraint(equalTo: urgentProductView.rightAnchor, constant: -10),
            urgentProductLabel.centerYAnchor.constraint(equalTo: urgentProductView.centerYAnchor),
        ])
    }

}

