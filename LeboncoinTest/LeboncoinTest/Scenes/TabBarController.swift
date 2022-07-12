//
//  TabBarController.swift
//  LeboncoinTest
//
//  Created by CHEN on 11/07/2022.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        setupTabBarColor()
        
    }
    
    func setupTabBarColor() {
        
        self.tabBar.barTintColor = .white
        //isTranslucent must be set to false cause the barTintColor of tabBar is in low opacity
        self.tabBar.isTranslucent = false
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    
    /*
     The function return an array of viewController. Each viewController will be related to an item of the TabBarController.
     Each item have icon and selected icon which is green. and the title is set to white at normal state and green at selected state
     Then adjust the size and positions of item title and icon.
     */
    func setupTabBarController(coordinator: MainCoordinator) -> [UIViewController] {
        self.tabBar.tintColor = .orange
        
        let dashboardVC = DashboardVC()
        dashboardVC.coordinator = coordinator
        
        let favoriteProductsVC = FavoriteProductsVC()
        favoriteProductsVC.coordinator = coordinator

        var dashboardImage = UIImage(named: "dashboard_icon")
        
        var favoriteImage: UIImage? = UIImage(named: "favorite_icon")
        
        let dimension: CGFloat = 25
        let framework: UIImage.ResizeFramework = .coreGraphics
        dashboardImage = dashboardImage?.resizeWithScaleAspectFitMode(to: dimension, resizeFramework: framework)
        favoriteImage = favoriteImage?.resizeWithScaleAspectFitMode(to: dimension, resizeFramework: framework)
        
        let item1 = UITabBarItem(title: "Dashboard", image: dashboardImage, selectedImage: dashboardImage)
        item1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        let item2 = UITabBarItem(title: "Favoris", image: favoriteImage, selectedImage: favoriteImage)
        item2.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
        
        item1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
        item2.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
        
        dashboardVC.tabBarItem = item1
        favoriteProductsVC.tabBarItem = item2
        let controllers = [dashboardVC, favoriteProductsVC]
        return controllers
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
    
    
}
