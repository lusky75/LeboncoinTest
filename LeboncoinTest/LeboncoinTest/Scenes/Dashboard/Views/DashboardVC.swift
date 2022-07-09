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
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetchProductsListRequest()
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
    
    // MARK: Request
    
    func fetchProductsListRequest() {
        
        ServicesAPIManager.shared.fetchProductsList(url: .listingProducts, completionHandler: {
            (data, error) in
            if let error = error {
                print("error on request api \(error)")
                return
            }
            if let data = data {
                self.productsViewModel?.listOfProducts = data
                self.dashboardView?.collectionView.reloadData()
            }
        })
    }
    
    // MARK: Action
    
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
        return productsViewModel?.listOfProducts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        let product: Product = productsViewModel!.listOfProducts[indexPath.row]
        let imageAddress = product.images_url?.small
        cell.productCardView.productImageView.loadFrom(URLAddress: imageAddress ?? "")
        cell.productCardView.productTitleLabel.text = product.title
        cell.productCardView.productPriceLabel.text = String(product.price)
        
        return cell
    }
    
    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateItemAction()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
}

