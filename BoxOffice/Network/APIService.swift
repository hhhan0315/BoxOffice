//
//  APIService.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import Foundation

final class APIService {
    private func makeURLRequest(with api: TargetType) -> URLRequest? {
        guard var urlComponents = URLComponents(string: api.baseURL + api.path) else {
            return nil
        }
        
        urlComponents.queryItems = api.query?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method.rawValue
        urlRequest.allHTTPHeaderFields = api.headers
        
        return urlRequest
    }
    
    private func download(with urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.responseIsNil
        }
        
        switch httpResponse.statusCode {
        case (200...299):
            return data
        case (400...499):
            throw APIError.status_400
        case (500...599):
            throw APIError.status_500
        default:
            throw APIError.unexpectedResponse
        }
    }
    
    func request<T: Decodable>(api: TargetType,
                               dataType: T.Type) async throws -> T {
        guard let urlRequest = makeURLRequest(with: api) else {
            throw APIError.invalidURLRequest
        }
        
        let data = try await download(with: urlRequest)
        
        do {
            let decodeData = try JSONDecoder().decode(T.self, from: data)
            return decodeData
        } catch {
            throw APIError.decodeError
        }
    }
}
