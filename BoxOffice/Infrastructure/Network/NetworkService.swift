//
//  NetworkService.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURLRequest = "URLRequest가 유효하지 않습니다."
    case sessionError = "네트워크 통신에 문제가 있습니다."
    case responseIsNil = "서버 응답이 오지 않았습니다."
    case unexpectedData = "예상치 못한 데이터를 수신했습니다."
    case unexpectedResponse = "예상치 못한 서버응답이 왔습니다."
    case decodeError = "디코딩에 문제가 있습니다."
    case status_200 = "예상한 응답이 왔습니다."
    case status_400 = "잘못된 요청입니다."
    case status_500 = "서버 오류입니다."
}

final class NetworkService {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
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
    
    func request<T: Decodable>(api: TargetType,
                               dataType: T.Type) async throws -> T {
        guard let urlRequest = makeURLRequest(with: api) else {
            throw NetworkError.invalidURLRequest
        }
                
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseIsNil
        }
        
        switch httpResponse.statusCode {
        case (200...299):
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                return decodeData
            } catch {
                throw NetworkError.decodeError
            }
        case (400...499):
            throw NetworkError.status_400
        case (500...599):
            throw NetworkError.status_500
        default:
            throw NetworkError.unexpectedResponse
        }
    }
}
