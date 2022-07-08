//
//  ProductCardView.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import Foundation
import UIKit

@IBDesignable
class ProductCardView: UIView {
    
    var productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        //imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var productTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var productPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .orange
        return label
    }()
    
    var productDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.numberOfLines = 0
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
    }
    
    func setupViewsConstraints() {
        NSLayoutConstraint.activate([
            
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            productImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            productImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor, multiplier: 1.25),
            
            productTitleLabel.leftAnchor.constraint(equalTo: productImageView.leftAnchor),
            productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productTitleLabel.rightAnchor.constraint(equalTo: productImageView.rightAnchor),
            
            productPriceLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 5),
            productPriceLabel.leftAnchor.constraint(equalTo: productTitleLabel.leftAnchor),
            productPriceLabel.rightAnchor.constraint(equalTo: productTitleLabel.rightAnchor),
            productPriceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
        ])
    }

}

