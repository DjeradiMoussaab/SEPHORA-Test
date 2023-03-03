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
    private var imageLoader: ImageLoaderProtocol
    
    let products = PublishSubject<[ProductListSection]>()
    
    let state = BehaviorSubject<State>(value: .loading)
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
        self.productEntityManager = ProductEntityManager()
        self.imageLoader = ImageLoader(apiClient: apiClient)
    }

    func fetchProductList(_ disposeBag: DisposeBag) {
                
        apiClient.perform(ProductEndpoint.getProductList)
            .map({ product -> [Product] in
                return product
            })
            .map({ product -> [ProductListSection] in
                self.productEntityManager.save(model: product)
                return self.transform(products: product)
            })
            .subscribe(onNext: { product  in
                print("^^ \(product.count)")
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
    
    func downloadImage(withImageURL imageUrl: String) -> Observable<UIImage> {
        do {
            guard let url = URL(string: imageUrl) else { throw ErrorType.invalideURL }
            return imageLoader.loadImage(from: url)
        } catch {
            return Observable.just(UIImage())
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
