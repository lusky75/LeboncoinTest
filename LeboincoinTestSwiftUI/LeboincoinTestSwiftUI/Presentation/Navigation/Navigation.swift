//
//  Navigation.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 07/10/2024.
//

import Foundation
import SwiftUI

class Navigation {
    struct Deeplink {
        enum Name: String {
            case page
        }
    }
    
    static func destinationForEntrypoint(_ entrypoint: String) -> some View {
        if let firstPath = entrypoint.path(at: 0),
           let secondPath = entrypoint.path(at: 1) {
            switch firstPath {
            case Deeplink.Name.page.rawValue:
                PageConfigurator.configurePageView(with: secondPath)
            default:
                Text("Hello")
            }
        }
        return Text("Hello")
    }
}
