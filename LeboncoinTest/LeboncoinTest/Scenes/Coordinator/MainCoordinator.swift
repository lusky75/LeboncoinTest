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
    
    var tabBarController: TabBarController
    
    /*
     productDetail takes the content of the selected product. The content will be used at ProductDetailVC
     */
    var productDetail: Product?

    init(navigationController: UINavigationController, tabBarController: TabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    /*
     the method start will define the root ViewController of Coordinator as DashboardVC
     */
    func start() {
        let dashboardVC = DashboardVC()
        dashboardVC.coordinator = self
        tabBarController.setViewControllers(tabBarController.setupTabBarController(coordinator: self), animated: true)
        self.navigationController.pushViewController(tabBarController, animated: false)
    }
    
    func navigateToProductDetail() {
        let productDetailVC = ProductDetailVC()
        productDetailVC.coordinator = self
        //self.navigationController.navigationItem.title = "Dashboard"
        self.navigationController.pushViewController(productDetailVC, animated: true)
        
    }
    
    func navigateToProductDetailPhoto() {
        let productDetailPhotoVC = ProductDetailPhotoVC()
        productDetailPhotoVC.coordinator = self
        self.navigationController.pushViewController(productDetailPhotoVC, animated: true)
    }
}

