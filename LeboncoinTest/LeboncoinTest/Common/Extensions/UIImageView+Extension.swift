//
//  UIImageView+Extensions.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            print("url not found: \(URLAddress)")
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            } else {
                print("No imageData from \(url)")
            }
        }
    }
    
}
