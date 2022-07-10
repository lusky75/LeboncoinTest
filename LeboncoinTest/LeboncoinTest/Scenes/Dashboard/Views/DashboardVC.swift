//
//  DashboardVC.swift
//  LeboncoinTest
//
//  Created by CHEN on 08/07/2022.
//

import UIKit

class DashboardVC: UIViewController {
    
    /*
     dashboardView contains components, constraints of Dashboard screen
     */
    var dashboardView: DashboardView?
    
    var coordinator: MainCoordinator?
    
    /*
     productsViewModel will receive list data fetched from request API and it will be used for Dashboard's component
     It also searchs category of a product
     */
    var productsViewModel: ProductsViewModel?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupDashboardView()
        
        productsViewModel = ProductsViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetchProductsListRequest()
        
        fetchProductCategoryRequest()
    }
    
    /*
     Initiate dashboardView's frame and components and add as view's subview
     */
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
    
    /*
     Get all products from request API and fill it at productsViewModel's listOfProducts
     */
    func fetchProductsListRequest() {
        
        ServicesAPIManager.shared.fetchProductsList(url: .listingProducts, completionHandler: {
            (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                self.productsViewModel?.listOfProducts = data
                self.productsViewModel?.sortListOfProductsByDate()
                self.dashboardView?.collectionView.reloadData()
            }
        })
    }
    
    /*
     Get all categories from request API and fill it at productsViewModel's listOfCategories
     */
    func fetchProductCategoryRequest() {
        
        ServicesAPIManager.shared.fetchProductCategories(url: .productCategories, completionHandler: {
            (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                self.productsViewModel?.listOfCategories = data
            }
        })
    }
    
}

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsViewModel?.listOfProducts.count ?? 0
    }
    
    /*
     For each product, it fill the content (image, title, price and category's name) for the cell: ProductCollectionViewCell
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        
        let product: Product = productsViewModel!.listOfProducts[indexPath.row]
        
        let imageAddress = product.images_url?.small
        cell.productCardView.productImageView.loadFrom(URLAddress: imageAddress ?? "")
        cell.productCardView.productTitleLabel.text = product.title
        cell.productCardView.productPriceLabel.text = String(Int(product.price)) + " €"
        cell.productCardView.productCategoryLabel.text = productsViewModel!.searchCategory(category_id: product.category_id)
        if product.is_urgent {
            cell.productCardView.urgentProductView.isHidden = false
        }
        return cell
    }
    
    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    /*
     Split the size for for each collectionView's cell to half of width's screen and height of 400. Added a spacing: 2 - lay.minimumInteritemSpacing
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: 400)
    }
    
    /*
     Select a product, will navigate to the productDetailVC of this product
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.productDetail = productsViewModel?.listOfProducts[indexPath.row]
        coordinator?.navigateToProductDetail()
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    */
    
}

