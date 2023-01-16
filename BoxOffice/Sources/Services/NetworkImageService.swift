//
//  NetworkImageService.swift
//  BoxOffice
//
//  Created by rae on 2022/11/22.
//

import Foundation

import RxSwift

final class NetworkImageService {
    private let cache = URLCache.shared
    private let urlSession = URLSession.shared
    
    private func loadFromCache(with urlRequest: URLRequest) -> Data? {
        return self.cache.cachedResponse(for: urlRequest)?.data
    }
    
    func execute(with urlString: String) -> Observable<Data> {
        return Observable.create { observer in
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlString)") else {
                observer.onError(NetworkError.invalidURLRequest)
                return Disposables.create()
            }
            
            let urlRequest = URLRequest(url: url)
            
            if let data = self.loadFromCache(with: urlRequest) {
                observer.onNext(data)
                observer.onCompleted()
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else {
                    observer.onError(NetworkError.unexpectedData)
                    return
                }
                
                guard let response = response else {
                    observer.onError(NetworkError.responseIsNil)
                    return
                }
                
                let cachedData = CachedURLResponse(response: response, data: data)
                self.cache.storeCachedResponse(cachedData, for: urlRequest)
                
                observer.onNext(data)
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
