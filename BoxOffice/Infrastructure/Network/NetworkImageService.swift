//
//  NetworkImageService.swift
//  BoxOffice
//
//  Created by rae on 2022/11/22.
//

import Foundation

final class NetworkImageService {
    private let cache = URLCache.shared
    private let urlSession = URLSession.shared
    
    private func downloadImage(with url: URL) async throws -> Data {
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseIsNil
        }
        
        switch httpResponse.statusCode {
        case (200...299):
            let cachedData = CachedURLResponse(response: response, data: data)
            self.cache.storeCachedResponse(cachedData, for: urlRequest)
            return data
        case (400...499):
            throw NetworkError.status_400
        case (500...599):
            throw NetworkError.status_500
        default:
            throw NetworkError.unexpectedResponse
        }
    }
    
    private func loadFromCache(with url: URL) async throws -> Data? {
        let urlRequest = URLRequest(url: url)
        return self.cache.cachedResponse(for: urlRequest)?.data
    }
    
    func getImage(with urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURLRequest
        }
        if let data = try await loadFromCache(with: url) {
            return data
        } else {
            return try await downloadImage(with: url)
        }
    }
}
