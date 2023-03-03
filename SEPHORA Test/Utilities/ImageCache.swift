//
//  ImageCache.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import UIKit

protocol ImageCacheType {
    
    func image(for url: URL) -> UIImage?
    
    func insertImage(_ image: UIImage?, for url: URL)
    
    func removeImage(for url: URL)
        
    subscript(_ url: URL) -> UIImage? { get set }
}
