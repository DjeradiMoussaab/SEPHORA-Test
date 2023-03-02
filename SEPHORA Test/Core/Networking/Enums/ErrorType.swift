//
//  ErrorType.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation

// MARK: - Request Error Type Enumeration

enum ErrorType : Error {
    case DecodingError
    case invalideURL
    case invalideResponse
    case unauthorized
    case unknown
    case network
    
    var message : String {
        switch self {
        case .DecodingError:
            return "Decoding Error"
        case .invalideURL:
            return "Invalide URL"
        case .invalideResponse:
            return "Invalide Response"
        case .unauthorized:
            return "Access Denied"
        case .unknown:
            return "Unkown Error"
        case .network:
            return "Network Error"
        }
    }
}
