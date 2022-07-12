//
//  BaseView.swift
//  LeboncoinTest
//
//  Created by CHEN on 12/07/2022.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    var viewTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.setBoldAppFont(size: 24)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(viewTitleLabel)
        
        NSLayoutConstraint.activate([
            viewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            viewTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            viewTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
