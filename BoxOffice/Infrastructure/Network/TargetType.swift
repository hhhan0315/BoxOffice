//
//  TargetType.swift
//  BoxOffice
//
//  Created by rae on 2022/11/19.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol TargetType {
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var query: [String: String]? { get }
    var headers: [String: String]? { get }
    var urlRequest: URLRequest? { get }
}

extension TargetType {
    var urlRequest: URLRequest? {
        var urlComponents = URLComponents(string: baseURL + path)
        urlComponents?.queryItems = query?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
}
