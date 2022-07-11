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
    
    var productDetail: Product?

    init(navigationController: UINavigationController) {
        print("init navigationController\(navigationController)")
        self.navigationController = navigationController
    }

    func start() {
        let dashboardVC = DashboardVC()
        dashboardVC.coordinator = self
        self.navigationController.pushViewController(dashboardVC, animated: false)
    }
    
    func navigateToProductDetail() {
        
        print("navigate to product detail: \(String(describing: productDetail))")
        let productDetailVC = ProductDetailVC()
        productDetailVC.coordinator = self
        self.navigationController.pushViewController(productDetailVC, animated: true)
        
    }
}

