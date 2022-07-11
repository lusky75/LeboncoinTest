//
//  ProductCategoryCollectionViewCell.swift
//  LeboncoinTest
//
//  Created by CHEN on 11/07/2022.
//

import Foundation
import UIKit

class ProductCategoryCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ProductCategoryCollectionViewCell"
    
    var categoryView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.75
        return view
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.setAppFont(size: 14)
        label.textColor = .black
        return label
    }()
    
    override func layoutSubviews() {
        
        addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            categoryView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            categoryView.heightAnchor.constraint(equalToConstant: 30),
            
            categoryLabel.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor, constant: 15),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryView.trailingAnchor, constant: -15),
        ])
    }
}
