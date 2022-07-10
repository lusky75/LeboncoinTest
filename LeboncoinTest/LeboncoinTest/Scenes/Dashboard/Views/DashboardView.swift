//
//  DashboardView.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import Foundation
import UIKit

class DashboardView: UIView {
    
    var filterButton: UIButton = {
        var button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Filtres", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.setAppFont(size: 14)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 15
        
        let widthSpacing: CGFloat = 15.0
        let heightSpacing: CGFloat = 2.5
        button.contentEdgeInsets = UIEdgeInsets(top: heightSpacing, left: widthSpacing, bottom: heightSpacing, right: widthSpacing)
        return button
    }()
    
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
        
        addSubview(filterButton)
        addSubview(collectionView)
                
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            filterButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            filterButton.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
