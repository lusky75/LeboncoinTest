//
//  ProductRowCard.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 03/10/2024.
//

import SwiftUI

struct ProductRowCard: View {
    @ObservedObject var viewModel: ProductRowCardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                AsyncImageView(imageUrl: viewModel.imageUrl,
                               height: 250,
                               placeholder: "horizontal_placeholder",
                               resizerWidth: 150)
            }
            .cornerRadius(10)
            .frame(width: 150, height: 250)
            
            if let title = viewModel.title {
                Text(title)
                    .font(.custom(.helveticaNeue65, size: 20))
                    .lineLimit(3)
            }
            if let price = viewModel.price {
                Text(price)
                    .font(.custom(.helveticaNeue65, size: 20))
            }
            if let category = viewModel.category {
                Text(category)
                    .font(.custom(.helveticaNeue35, size: 18))
            }
            
            if viewModel.isUrgent {
                HStack {
                    Text(viewModel.urgentTitle)
                        .font(.system(size: 11)) // Similar to UIFont.setAppFont(size: 11)
                        .foregroundColor(.orange)
                        .padding(.horizontal, 10)
                        .frame(height: 20)
                        .background(Color.orange.opacity(0.15)) // UIColor.orange.withAlphaComponent(0.15)
                        .cornerRadius(10)
                }
                .padding(.top, 5)
            
            }
        }
    }
}

#Preview {
    ProductRowCard(viewModel: ProductRowCardViewModel(model: Product.fake()))
}
