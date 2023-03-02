//
//  Product.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import UIKit

struct Product: Decodable, Hashable {
    
    private let identifier = UUID()
        
    enum CodingKeys: String, CodingKey {
        
        case id = "product_id"
        case name = "product_name"
        case description
        case price
        case image = "images_url"
        case brand = "c_brand"
        case isSpecial = "is_special_brand"
        case isProductSet = "is_productSet"
    }
    
    let id: Int
    let name: String
    let description: String
    let price: Double
    let image: Image
    let brand: Brand
    let isSpecial: Bool
    let isProductSet: Bool

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

struct Image: Decodable {
    enum CodingKeys: String, CodingKey {
        case small
        case large
    }
    
    let small: String
    let large: String
}

struct Brand: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    let id: String
    let name: String

}

