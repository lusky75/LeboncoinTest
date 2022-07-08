//
//  ProductCollectionViewCell.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import Foundation
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ProductCollectionViewCell"
    
    var productCardView: ProductCardView = {
        var view = ProductCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func layoutSubviews() {
        
        addSubview(productCardView)
        
        NSLayoutConstraint.activate([
            productCardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            productCardView.widthAnchor.constraint(equalTo: self.widthAnchor),
            productCardView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
}
