//
//  KobisRepository.swift
//  BoxOffice
//
//  Created by rae on 2023/01/04.
//

import Foundation

import RxSwift

final class KobisRepository {
    private let networkService = NetworkService()
    private let key = Secrets.kobisKey
    
    func getDailyBoxOfficeListResponse() -> Observable<DailyBoxOfficeListResponseDTO> {
        let yesterday = Date.yesterday.toString(.yyyyMMdd)
        let request = DailyBoxOfficeListRequestDTO(key: self.key, targetDt: yesterday)
        let api = KobisAPI.getDailyBoxOfficeList(request)
        let urlRequest = api.urlRequest
        return networkService.execute(urlRequest: urlRequest)
    }
}
