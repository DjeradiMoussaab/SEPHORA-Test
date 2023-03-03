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

    
    override func viewDidLoad() {
        setupNavigationBar()
        setupViews()
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "SEPHORA"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground

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
