//
//  ImageLoader.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import UIKit
import RxSwift

protocol ImageLoaderProtocol {
    func loadImage(from url: URL) -> Observable<UIImage>
}


final class ImageLoader: ImageLoaderProtocol {
    
    private var apiClient: APIClientProtocol
    private var imageCache: ImageCacheType
    
    init(apiClient: APIClientProtocol, imageCache: ImageCacheType = ImageCache()) {
        self.apiClient = apiClient
        self.imageCache = ImageCache()
    }
    
    func loadImage(from url: URL) -> Observable<UIImage> {
        
        if let image = imageCache[url] {
            return Observable.just(image)
        }
        
        return apiClient
            .perform(ImageEndpoint.downloadImage(path: url.path))
            .map {[unowned self] image in
                self.imageCache[url] = image
                return image
            }
    }
}
