//
//  FavoriteProductsView.swift
//  LeboncoinTest
//
//  Created by CHEN on 12/07/2022.
//

import Foundation
import UIKit

class FavoriteProductsView: BaseView {
    
    var collectionView: UICollectionView = {
        var collectionFlow: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionFlow.minimumInteritemSpacing = 8
        collectionFlow.scrollDirection = .vertical
        
        collectionFlow.minimumLineSpacing = 0
        var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlow)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.tag = 2
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: viewTitleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
