//
//  EndpointMock.swift
//  SEPHORA TestTests
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation

@testable import SEPHORA_Test

enum EndpointMock: Endpoint {
    case getProductList
}

extension EndpointMock {

    var path: String {
        guard let path = Bundle.main.path(forResource: "ProductList", ofType: "json") else {
            fatalError("Unable to find ProductList.json")
        }
        return path
    }
}
