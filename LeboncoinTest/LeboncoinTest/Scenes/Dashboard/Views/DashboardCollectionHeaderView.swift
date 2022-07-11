//
//  DashboardCollectionHeaderView.swift
//  LeboncoinTest
//
//  Created by CHEN on 11/07/2022.
//

import Foundation
import UIKit

class DashboardCollectionHeaderView: UICollectionReusableView {
    
    static let cellIdentifier = "DashboardCollectionHeaderView"
    
    var numberOfResultLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.setBoldAppFont(size: 18)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(numberOfResultLabel)

        NSLayoutConstraint.activate([
            
            numberOfResultLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            numberOfResultLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
