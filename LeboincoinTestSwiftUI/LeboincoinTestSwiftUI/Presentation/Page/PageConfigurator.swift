//
//  PageConfigurator.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 07/10/2024.
//

import Foundation

final class PageConfigurator {
    public static func configurePageView(with externalId: String) -> PageView {
        let pageView = PageView(viewModel: PageViewModel(externalId: externalId))
        return pageView
    }
}
