//
//  PageViewModel.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 07/10/2024.
//

import Foundation

class PageViewModel: ObservableObject {
    let externalId: String
    
    init(externalId: String) {
        self.externalId = externalId
    }
}
