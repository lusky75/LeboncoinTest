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
            HomeView(viewModel: HomeViewModel())
        }
    }
}
