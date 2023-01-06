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
        guard self.key.isEmpty == false else {
            return Observable.error(NetworkError.invalidAPIKey)
        }
        
        let yesterday = Date.yesterday.toString(.yyyyMMdd)
        let request = DailyBoxOfficeListRequestDTO(key: self.key, targetDt: yesterday)
        let api = KobisAPI.getDailyBoxOfficeList(request)
        let urlRequest = api.urlRequest
        return networkService.execute(urlRequest: urlRequest)
    }
    
    func getWeeklyBoxOfficeListResponse(with kobisWeekType: KobisWeekType) -> Observable<WeeklyBoxOfficeListResponseDTO> {
        guard self.key.isEmpty == false else {
            return Observable.error(NetworkError.invalidAPIKey)
        }
        
        let targetDate = Date.oneWeekAge.toString(.yyyyMMdd)
        let request = WeeklyBoxOfficeListRequestDTO(key: self.key, targetDt: targetDate, weekGb: kobisWeekType)
        let api = KobisAPI.getWeeklyBoxOfficeList(request)
        let urlRequest = api.urlRequest
        return networkService.execute(urlRequest: urlRequest)
    }
}
