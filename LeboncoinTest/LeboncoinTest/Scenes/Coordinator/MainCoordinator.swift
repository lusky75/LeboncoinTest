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
    
    /*
     productDetail takes the content of the selected product. The content will be used at ProductDetailVC
     */
    var productDetail: Product?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /*
     the method start will define the root ViewController of Coordinator as DashboardVC
     */
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

