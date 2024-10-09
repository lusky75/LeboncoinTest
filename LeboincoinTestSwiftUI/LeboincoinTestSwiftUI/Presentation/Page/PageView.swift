//
//  PageView.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 07/10/2024.
//

import SwiftUI

struct PageView: View {
    @ObservedObject var viewModel: PageViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PageView(viewModel: PageViewModel(externalId: ""))
}
