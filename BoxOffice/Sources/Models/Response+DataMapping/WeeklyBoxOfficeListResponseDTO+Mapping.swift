//
//  WeeklyBoxOfficeListResponseDTO+Mapping.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct WeeklyBoxOfficeListResponseDTO: Decodable {
    let boxOfficeResult: BoxOfficeResultDTO
}

extension WeeklyBoxOfficeListResponseDTO {
    struct BoxOfficeResultDTO: Decodable {
        let boxofficeType: String
        let showRange: String
        let weeklyBoxOfficeList: [BoxOfficeListDTO]
        
        struct BoxOfficeListDTO: Decodable {
            let rank: String
            let rankInten: String
            let rankOldAndNew: String
            let movieCd: String
            let movieNm: String
            let openDt: String
            let audiAcc: String
        }
    }
}

extension WeeklyBoxOfficeListResponseDTO.BoxOfficeResultDTO.BoxOfficeListDTO {
    func toDomain() -> BoxOfficeList {
        return .init(rank: rank,
                     rankInten: rankInten,
                     rankOldAndNew: rankOldAndNew,
                     movieCode: movieCd,
                     movieName: movieNm,
                     openDate: openDt,
                     audienceAcc: audiAcc)
    }
}
