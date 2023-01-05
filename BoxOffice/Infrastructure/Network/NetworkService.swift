//
//  NetworkService.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

import RxSwift

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
    func execute<T: Decodable>(urlRequest: URLRequest?) -> Observable<T> {
        return Observable.create { observer in
            guard let urlRequest = urlRequest else {
                observer.onError(NetworkError.invalidURLRequest)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else {
                    observer.onError(NetworkError.unexpectedData)
                    return
                }
                
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    observer.onError(NetworkError.decodeError)
                    return
                }
                
                observer.onNext(decodedData)
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
