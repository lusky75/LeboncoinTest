//
//  HomeView.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: onAppear)
    }
}

extension HomeView {
    private func onAppear() {
        viewModel.onAppear()
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
