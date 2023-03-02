//
//  ProductEndpoint.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation

// MARK: - The Product Endpoint

enum ProductEndpoint: Endpoint {
    case getProductList
}

extension ProductEndpoint {
    var httpMethod: RequestType {
        switch self {
        case .getProductList:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .getProductList:
            return APIConstants.productListPath
        }
    }
}

// MARK: - Product Endpoint Necessary Paths

extension APIConstants {
    static let productListPath = "/items.json"
}
