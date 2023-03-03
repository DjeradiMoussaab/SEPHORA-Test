//
//  APIManagerMock.swift
//  SEPHORA TestTests
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import RxSwift
@testable import SEPHORA_Test

// MARK: - API Manager

final class APIManagerMock: APIManagerProtocol {
        
    func makeRequest(_ endpoint: Endpoint) throws -> Observable<(response: HTTPURLResponse, data: Data)>{
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: endpoint.path), options: .mappedIfSafe) else {
            throw ErrorType.invalideURL
        }
        return Observable.just((HTTPURLResponse(), data))
    }
    
}
