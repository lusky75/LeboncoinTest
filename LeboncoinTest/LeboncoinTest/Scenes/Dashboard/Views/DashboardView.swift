//
//  DashboardView.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import Foundation
import UIKit

class DashboardView: UIView {
    
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
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
                
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
