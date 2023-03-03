//
//  ViewController.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 2/3/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ProductListViewController: UIViewController {
    
    private var productListViewModel = ProductListViewModel()
    
    private let disposeBag = DisposeBag()
        
    private var loadingView = LoadingView()
    private var emptyView = EmptyView()
    private var errorView = ErrorView()
    
    private let refreshControl = UIRefreshControl()
    
    var collectionView: UICollectionView!

    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<ProductListSection>(configureCell:{ dataSource, collectionView, indexPath, product in
        
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.reuseIdentifier, for: indexPath) as! ProductListCell
        self.productListViewModel.downloadImage(withImageURL: product.image.small)
            .subscribe(on: MainScheduler.instance)
            .bind(to: productCell.imageView.rx.image)
            .disposed(by: self.disposeBag)
        productCell.configure(with: product)
        return productCell
    })

    
    override func viewDidLoad() {
        setupNavigationBar()
        setupViews()
        fetchProducts()
        //productListViewModel.fetchProductListFromCoreData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "SEPHORA"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: ProductListCell.reuseIdentifier)
        collectionView.refreshControl = refreshControl
        collectionView!.alwaysBounceVertical = true
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier)
        
        dataSource.configureSupplementaryView = { (dataSource, collectionView, kind, indexPath) in
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier, for: indexPath) as! HeaderCell
            if indexPath.section == 0 {
                cell.configure(with: ("Spéciales", "Les produits des marques spéciales"))
            } else {
                cell.configure(with: ("Autres produits", "Les produits de toutes les marques de SEPHORA"))
            }
            return cell
        }
        
        view.addSubview(collectionView)
    }
    
    func fetchProducts() {
        /// Use "state" value to switch which view to present
        productListViewModel.state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.addLoadingView()
                case .success:
                    self.removeLoadingView()
                case .empty:
                    self.removeLoadingView()
                    self.addEmptyView()
                case .fail:
                    self.removeLoadingView()
                    self.addErrorView()
                }
                self.refreshControl.endRefreshing()
                
            })
            .disposed(by: disposeBag)
        
        /// Use "products" after fetching is completed
        productListViewModel.products
            .subscribe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        collectionView.refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.productListViewModel.fetchProductList(self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        /// fetch products
        productListViewModel.fetchProductList(disposeBag)
        
        
    }
    
}

// MARK: - VIEW OPERATIONS

extension ProductListViewController {
    
    private func addLoadingView() {
        self.loadingView.stopAnimating()
        self.addView(self.loadingView)
    }
    
    private func removeLoadingView() {
        self.loadingView.removeFromSuperview()
    }
    
    private func addEmptyView() {
        self.addView(self.emptyView)
    }
    
    private func removeEmptyView() {
        self.emptyView.removeFromSuperview()
    }
    
    private func addErrorView() {
        self.addView(self.errorView)
    }
    
    private func removeErrorView() {
        self.errorView.removeFromSuperview()
    }
    
}



// MARK: - COMPOSITIONAL LAYOUT

extension ProductListViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if (sectionIndex == 0 ) {
                return self.createHorizontalSectionLayout()
            } else {
                return self.createVericalSectionLayout()
            }
        }
        return layout
    }
    
    private func createHorizontalSectionLayout() -> NSCollectionLayoutSection {
        
        /// create sizes for items and groups.
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let groupeSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(292))
        
        /// create item and group.
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupeSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(88))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        
        /// create the section.
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createVericalSectionLayout() -> NSCollectionLayoutSection {
        
        /// create sizes for items and groups.
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let groupeSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(284))
        
        /// create item and group.
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupeSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(90))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        /// create the section.
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}
