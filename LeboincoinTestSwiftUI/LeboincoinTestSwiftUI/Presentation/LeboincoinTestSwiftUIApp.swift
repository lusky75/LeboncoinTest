//
//  LeboincoinTestSwiftUIApp.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import SwiftUI

@main
struct LeboincoinTestSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(viewModel: HomeViewModel())
                    .tabItem {
                        Image(systemName: "chart.bar")
                        
                        Text("Dashboard")
                    }
                
                VStack {
                    Text("Vos favoris")
                }
                .tabItem {
                    Image(systemName: "heart")
                    
                    Text("Favorite")
                }
            }
            .accentColor(.orange)
            .onAppear {
                setupTabBarAppearance()
            }
        }
    }
    
    // Function to customize the tab bar appearance
    private func setupTabBarAppearance() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().isTranslucent = false
        
        // iOS 15 and above, setting tab bar appearance
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
