//
//  MainCoordinator.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        print("init navigationController\(navigationController)")
        self.navigationController = navigationController
    }

    func start() {
        
        print("start")
        let dashboardVC = DashboardVC()
        dashboardVC.coordinator = self
        self.navigationController.pushViewController(dashboardVC, animated: false)
    }
    
    func navigateToProductDetail() {
        
        print("create account")
        let productDetailVC = ProductDetailVC()
        productDetailVC.coordinator = self
        self.navigationController.pushViewController(productDetailVC, animated: true)
        
    }
}

