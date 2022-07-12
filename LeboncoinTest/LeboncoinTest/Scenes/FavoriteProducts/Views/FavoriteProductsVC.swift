//
//  FavoriteProductsVC.swift
//  LeboncoinTest
//
//  Created by CHEN on 11/07/2022.
//

import UIKit

class FavoriteProductsVC: UIViewController {
    
    var favoriteProductsView: FavoriteProductsView?
    
    var favorites: Favorites?
    
    var listOfProducts: [Product] = []
    
    var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         accessibilityIdentifier is used for UI unit tests
        */
        view.accessibilityIdentifier = Constants.AccessibilityIdentifier.favoriteProducts
        
        view.backgroundColor = .white
    
        setupFavoriteProductsView()
    }
    
    /*
     viewWillAppear is initiated and called when user select Favorite from TabBar or pop back from ProductDetail page
     */
    override func viewWillAppear(_ animated: Bool) {
        favoriteProductsView?.collectionView.reloadData()
    }
    
    func setupFavoriteProductsView() {
        favoriteProductsView = FavoriteProductsView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - self.tabBarController!.tabBar.frame.height))
                
        view.addSubview(favoriteProductsView!)
        
        favoriteProductsView?.viewTitleLabel.text = "Vos favoris"
        
        setupFavoriteProductsCollectionView()
    }
    
    func setupFavoriteProductsCollectionView() {
        favoriteProductsView?.collectionView.delegate = self
        favoriteProductsView?.collectionView.dataSource = self
        favoriteProductsView?.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.cellIdentifier)
        
        //dashboardView?.collectionView.register(DashboardCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DashboardCollectionHeaderView.cellIdentifier)
    }

}

extension FavoriteProductsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favorites = Favorites()
        listOfProducts.removeAll()
        for product in favorites!.products {
            listOfProducts.append(product)
        }
        return listOfProducts.count
    }
    
    /*
     For each product, it fill the content (image, title, price and category's name) for the cell: ProductCollectionViewCell
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        let product: Product = listOfProducts[indexPath.row]
        
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
        cell.productCardView.productCategoryLabel.text = ProductsViewModel().searchCategory(category_id: product.category_id)
        if product.is_urgent {
            cell.productCardView.urgentProductView.isHidden = false
        } else {
            cell.productCardView.urgentProductView.isHidden = true
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
        if widthPerItem > 300 {
            return CGSize(width: widthPerItem, height: widthPerItem * 2)
        }
        return CGSize(width: widthPerItem, height: widthPerItem * 2.35)
    }
    
    /*
     Select a product, will navigate to the productDetailVC of this product
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.productDetail = listOfProducts[indexPath.row]
        coordinator?.navigateToProductDetail()
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    */
}
