//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by rae on 2022/11/22.
//

import Foundation

final class ImageCacheManager {
    private let cache = URLCache.shared
    
    private func downloadImage(imageURL: URL, completion: @escaping (Data) -> Void) {
        let request = URLRequest(url: imageURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else {
                return
            }
            
            let cachedData = CachedURLResponse(response: response, data: data)
            self.cache.storeCachedResponse(cachedData, for: request)
            completion(data)
        }.resume()
    }
    
    private func loadFromCache(imageURL: URL, completion: @escaping (Data) -> Void) {
        let request = URLRequest(url: imageURL)
        
        if let data = self.cache.cachedResponse(for: request)?.data {
            completion(data)
        }
    }
    
    func getImage(imageURL: URL, completion: @escaping (Data) -> Void) {
        let request = URLRequest(url: imageURL)
        
        if self.cache.cachedResponse(for: request) == nil {
            downloadImage(imageURL: imageURL) { data in
                completion(data)
            }
        } else {
            loadFromCache(imageURL: imageURL) { data in
                completion(data)
            }
        }
    }
}
