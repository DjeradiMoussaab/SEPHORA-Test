//
//  ProductListViewModel.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import RxDataSources


enum Section {
    case special
    case normal
}

enum State {
    case loading
    case success
    case fail
    case empty
}

typealias ProductListSection = SectionModel<Section, Product>

final class ProductListViewModel {
    
    private var apiClient: APIClientProtocol
    private var productEntityManager: ProductEntityManager
    
    var products = BehaviorSubject<[ProductListSection]>(value: [])
    
    var state = BehaviorSubject<State>(value: .loading)
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
        self.productEntityManager = ProductEntityManager()
        
        self.fetchProductListFromCoreData()
    }

    func fetchProductList(_ disposeBag: DisposeBag) {
                
        apiClient.perform(ProductEndpoint.getProductList)
            .delay(.seconds(4), scheduler: MainScheduler.instance)
            .map({ product -> [Product] in
                return product
            })
            .map({ product -> [ProductListSection] in
                self.productEntityManager.save(model: product)
                print("%%% products retrieved from WEB")
                print("%%% \(product.count)")
                return self.transform(products: product)
            })
            .subscribe(onNext: { product  in
                switch product.isEmpty {
                case true:
                    self.state.onNext(.empty)
                case false:
                    self.products.onNext(product)
                    self.state.onNext(.success)
                }
            }, onError: { error in
                self.state.onNext(.fail)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchProductListFromCoreData() {
        
        if let productEntities = productEntityManager.fetchAll() {
            print("%%% products retrieved from core DATA")
            let productsData = productEntities.map {
                productEntityManager.transform(entity: $0)
            }
            let productsListSection = self.transform(products: productsData)
            self.products.onNext([])
            switch productsListSection.isEmpty {
            case true:
                self.state.onNext(.empty)
            case false:
                self.products.onNext(productsListSection)
                self.state.onNext(.success)
            }
        }
    }
}


extension ProductListViewModel {
    
    private func transform(products: [Product]) -> [ProductListSection] {
        return [
            ProductListSection(
                model: .special,
                items: products.filter { $0.isSpecial }
            ),
            ProductListSection(
                model: .normal,
                items: products.filter { !$0.isSpecial }
            )
        ]
    }
}
