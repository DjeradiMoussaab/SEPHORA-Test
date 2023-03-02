//
//  APIManager.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - API Manager Protocol

protocol APIManagerProtocol {
    func makeRequest(_ endpoint: Endpoint) throws -> Observable<(response: HTTPURLResponse, data: Data)>
}

// MARK: - API Manager

final class APIManager: APIManagerProtocol {
        
    func makeRequest(_ endpoint: Endpoint) throws -> Observable<(response: HTTPURLResponse, data: Data)> {
        let requestURL = try endpoint.generateRequestURL()
        let data = URLSession.shared.rx.response(request: requestURL)
        return data
    }
    
}
