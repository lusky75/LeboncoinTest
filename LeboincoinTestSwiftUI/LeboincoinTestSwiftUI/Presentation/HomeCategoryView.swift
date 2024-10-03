//
//  HomeCategoryView.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import SwiftUI

struct HomeCategoryView: View {
    var title: String
    var selected: Bool
    
    var body: some View {
        HStack {
            Text(title.uppercased())
                .font(.system(size: 14))
                .foregroundColor(selected ? Color.tintColor : Color.gray700Color)
                .padding(.horizontal, 15)
        }
        .frame(height: 30)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(selected ? Color.tintColor : Color.gray700Color, lineWidth: 1)
        )
        .padding(.leading, 15)
        .padding(.vertical)
    }
}

#Preview {
    HomeCategoryView(title: "Véhicule", selected: false)
}
