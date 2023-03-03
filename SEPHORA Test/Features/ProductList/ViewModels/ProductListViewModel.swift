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

final class ProductListViewModel {
    
    private var apiClient: APIClientProtocol
    private var productEntityManager: ProductEntityManager
    
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
        self.productEntityManager = ProductEntityManager()
    }

}
