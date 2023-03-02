//
//  JSONParser.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation

// MARK: - JSON Parser Protocol

protocol JSONParserProtocol {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

// MARK: - JSON Parser
class JSONParser: JSONParserProtocol {
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        guard let decodedData = try? jsonDecoder.decode(T.self, from: data) else {
            throw ErrorType.DecodingError
        }
        return decodedData
    }
}
