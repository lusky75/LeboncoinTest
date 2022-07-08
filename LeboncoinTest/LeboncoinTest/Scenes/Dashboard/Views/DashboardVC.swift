//
//  DashboardVC.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import UIKit

class DashboardVC: UIViewController {
    
    var dashboardView: DashboardView?
    
    var coordinator: MainCoordinator?
    
    var productsViewModel: ProductsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DashboardVC")
        
        view.backgroundColor = .white
        
        setupDashboardView()
        
        productsViewModel = ProductsViewModel()
    }
    
    func setupDashboardView() {
        dashboardView = DashboardView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
                
        view.addSubview(dashboardView!)
        
        addButtonTarget()
        
        setupProductsCollectionView()
    }

    func addButtonTarget() {
    }
    
    func setupProductsCollectionView() {
            
        dashboardView?.collectionView.delegate = self
        dashboardView?.collectionView.dataSource = self
        dashboardView?.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.cellIdentifier)
    }
    
    @objc func navigateItemAction() {
        print("Message: I try to navigate to item !")
        coordinator?.navigateToProductDetail()
    }
    
}

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10//productsViewModel?.listOfProducts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        cell.productCardView.productImageView.loadFrom(URLAddress: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")
        cell.productCardView.productTitleLabel.text = "Statue homme noir assis en plâtre polychrome"
        cell.productCardView.productPriceLabel.text = String(140.00) + "€"
        
        return cell
    }
    
    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateItemAction()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
}

