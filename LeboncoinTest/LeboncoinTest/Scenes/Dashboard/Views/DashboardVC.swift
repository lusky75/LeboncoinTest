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
        
        /*
         accessibilityIdentifier is used for UI unit tests
        */
        view.accessibilityIdentifier = Constants.AccessibilityIdentifier.dashboard
        
        view.backgroundColor = .white
        
        setupDashboardView()
        
        productsViewModel = ProductsViewModel()
        
        if productsViewModel!.listOfProducts.isEmpty {
            fetchProductsListRequest()
        }
        
        if productsViewModel!.listOfCategories.isEmpty {
            fetchProductCategoryRequest()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    /*
     Initiate dashboardView's frame and components and add as view's subview
     */
    func setupDashboardView() {
        dashboardView = DashboardView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - self.tabBarController!.tabBar.frame.height))
                
        view.addSubview(dashboardView!)
        
        dashboardView?.viewTitleLabel.text = "Liste des produits"
        
        addButtonTarget()
        
        setupProductsCollectionView()
    }

    func addButtonTarget() {
    }
    
    func setupProductsCollectionView() {
        dashboardView?.collectionView.delegate = self
        dashboardView?.collectionView.dataSource = self
        dashboardView?.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.cellIdentifier)
        
        dashboardView?.collectionView.register(DashboardCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DashboardCollectionHeaderView.cellIdentifier)
        
        dashboardView?.categoriesCollectionView.delegate = self
        dashboardView?.categoriesCollectionView.dataSource = self
        dashboardView?.categoriesCollectionView.register(ProductCategoryCollectionViewCell.self, forCellWithReuseIdentifier: ProductCategoryCollectionViewCell.cellIdentifier)
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
                self.productsViewModel?.sortListOfProductsByDate(completion: {
                    self.dashboardView?.collectionView.reloadData()
                })
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
                self.productsViewModel?.listOfSelectedCategories.removeAll()
                for _ in 0...data.count {
                    self.productsViewModel?.listOfSelectedCategories.append(false)
                }
                self.dashboardView?.categoriesCollectionView.reloadData()
            }
        })
    }
    
}

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return productsViewModel?.listOfCategories.count ?? 0
        }
        if let listOfSelectedCategories = productsViewModel?.listOfSelectedCategories {
            productsViewModel?.isFiltered = false
            for select in listOfSelectedCategories {
                if select {
                    productsViewModel?.isFiltered = true
                    return productsViewModel?.listOfFilteredProducts.count ?? 0
                }
            }
        }
        return productsViewModel?.listOfProducts.count ?? 0
    }
    
    /*
     For each product, it fill the content (image, title, price and category's name) for the cell: ProductCollectionViewCell
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCategoryCollectionViewCell.cellIdentifier, for: indexPath) as! ProductCategoryCollectionViewCell
            
            if productsViewModel!.listOfSelectedCategories[indexPath.row] {
                cell.categoryView.layer.borderColor = UIColor.orange.cgColor
                cell.categoryView.layer.borderWidth = 2
                cell.categoryLabel.font = UIFont.setDemiBoldFont(size: 14)
                cell.categoryLabel.textColor = UIColor.orange
            } else {
                cell.categoryView.layer.borderColor = UIColor.lightGray.cgColor
                cell.categoryView.layer.borderWidth = 0.75
                cell.categoryLabel.font = UIFont.setAppFont(size: 14)
                cell.categoryLabel.textColor = UIColor.black
            }
            
            let category = productsViewModel?.listOfCategories[indexPath.row]
            cell.categoryLabel.text = category?.name
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellIdentifier, for: indexPath) as! ProductCollectionViewCell
            
            let product: Product
            if productsViewModel!.isFiltered {
                product = productsViewModel!.listOfFilteredProducts[indexPath.row]
            } else {
                product = productsViewModel!.listOfProducts[indexPath.row]
            }
            
            let widthPerItem = collectionView.frame.width / 2
            let imageAddress: String? //= product.images_url?.thumb
            
            if widthPerItem > 300 {
                imageAddress = product.images_url?.thumb
            } else {
                imageAddress = product.images_url?.small
            }
            cell.productCardView.productImageView.loadFrom(URLAddress: imageAddress ?? "")
            cell.productCardView.productTitleLabel.text = product.title
            cell.productCardView.productPriceLabel.text = String(Int(product.price)) + " €"
            cell.productCardView.productCategoryLabel.text = productsViewModel!.searchCategory(category_id: product.category_id)
            if product.is_urgent {
                cell.productCardView.urgentProductView.isHidden = false
            } else {
                cell.productCardView.urgentProductView.isHidden = true
            }
            return cell
        }
    }
    
    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    /*
     Split the size for for each collectionView's cell to half of width's screen and height of 400. Added a spacing: 2 - lay.minimumInteritemSpacing
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            let calculatedSize = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            calculatedSize.text = productsViewModel?.listOfCategories[indexPath.row].name

            calculatedSize.font = UIFont.setAppFont(size: 14)

            //sizing the calculatedSize, depends the number of characters from the button's title
            calculatedSize.sizeToFit()
            
            return CGSize(width: (calculatedSize.bounds.width + 40), height: 50)
        } else {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
            if widthPerItem > 300 {
                return CGSize(width: widthPerItem, height: widthPerItem * 2)
            }
            return CGSize(width: widthPerItem, height: widthPerItem * 2.35)
        }
    }
    
    /*
     Select a product, will navigate to the productDetailVC of this product
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            let selectCategoryValue: Bool = productsViewModel!.listOfSelectedCategories[indexPath.row]
            productsViewModel?.listOfSelectedCategories[indexPath.row] = !selectCategoryValue
            productsViewModel?.filterListOfProductsBySelectedCategories(completion: {
                dashboardView?.collectionView.reloadData()
                dashboardView?.categoriesCollectionView.reloadData()
            })
        } else {
            if productsViewModel!.isFiltered {
                coordinator?.productDetail = productsViewModel?.listOfFilteredProducts[indexPath.row]
            } else {
                coordinator?.productDetail = productsViewModel?.listOfProducts[indexPath.row]
            }
            coordinator?.navigateToProductDetail()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView.tag != 1 {
            switch kind {
                case UICollectionView.elementKindSectionHeader:
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DashboardCollectionHeaderView.cellIdentifier, for: indexPath)
                headerView.frame.size.height = 50
                headerView.frame.size.width = collectionView.frame.width
                guard let typedHeaderView = headerView as? DashboardCollectionHeaderView else {
                    return headerView
                }
                let numberOfResult: Int
                if productsViewModel!.isFiltered {
                    numberOfResult = productsViewModel!.listOfFilteredProducts.count
                } else {
                    numberOfResult = productsViewModel!.listOfProducts.count
                }
                typedHeaderView.numberOfResultLabel.text = String(numberOfResult) + " résultats"
                
                    return typedHeaderView
                case UICollectionView.elementKindSectionFooter:
                    return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                default:
                    return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            }
        }
        return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 0, height: 0)
        }
        let height: CGFloat
        if collectionView.frame.width > 600 {
            height = 50
        } else {
            height = 30
        }
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
}

