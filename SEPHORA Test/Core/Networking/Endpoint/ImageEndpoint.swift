//
//  ImageEndpoint.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation

// MARK: - Image Endpoint

enum ImageEndpoint: Endpoint {
    case downloadImage(path: String)
}

extension ImageEndpoint {
    var httpMethod: RequestType {
        return .GET
    }
    
    var path: String {
        switch self {
        case .downloadImage(let path) :
            return path
        }
    }
    
    var host: String {
        return APIConstants.imageHost
    }
}

extension APIConstants {
    static let imageHost = "dev.sephora.fr"
}
