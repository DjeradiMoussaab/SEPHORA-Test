//
//  APIClient.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import RxSwift

// MARK: - API Client Protocol

protocol APIClientProtocol {
    func perform<T:Decodable>(_ endpoint: Endpoint) -> Observable<T>
    func perform(_ endpoint: Endpoint) -> Observable<UIImage>
}

// MARK: - API Client

struct APIClient: APIClientProtocol {
    
    private let apiManager: APIManagerProtocol
    private let jsonParser: JSONParserProtocol
    
    init(_ apiManager: APIManagerProtocol = APIManager(),_ jsonParser: JSONParserProtocol = JSONParser()) {
        self.apiManager = apiManager
        self.jsonParser = jsonParser
    }
    
    func perform<T:Decodable>(_ endpoint: Endpoint) -> Observable<T> {

        return Observable.just(endpoint)
            .flatMap { Endpoint -> Observable<(response: HTTPURLResponse, data: Data)> in
                return try apiManager.makeRequest(endpoint)
            }
            .catch({ error in
                return .error(error)
            })
            .map { response, data -> T in
                let decodedResponse: T = try self.jsonParser.decode(data)
                return decodedResponse
            }
    }
    
    func perform(_ endpoint: Endpoint) -> Observable<UIImage> {
        
        return Observable.just(endpoint)
            .flatMap { Endpoint -> Observable<(response: HTTPURLResponse, data: Data)> in
                return try apiManager.makeRequest(endpoint)
            }
            .map { response, data in
                if let image = UIImage(data: data) {
                    return image
                } else {
                    return UIImage()
                }
                
            }
    }
    
}

