//
//  HomeViewModel.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 21/09/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private let homeService: HomeServiceProtocol
    
    /**
     We also add the cancellables property to store future subscriptions
    */
    private var cancellables = Set<AnyCancellable>()
    
    init(homeService: HomeServiceProtocol = HomeService()) {
        self.homeService = homeService
    }
    
    public func onAppear() {
        // Manage datas, helper or services if needed
        getListing()
    }
    private func getListing() {
        homeService.getListing()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    Log.error(error)
                case .finished: break
                }
            }, receiveValue: { response in
                print("ROUGEE response: \(response)")
            })
            .store(in: &cancellables)
    }
}
