//
//  WeeklyMoviesResponseDTO+Mapping.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct WeeklyMoviesResponseDTO: Decodable {
    let boxOfficeResult: BoxOfficeResultDTO
}

extension WeeklyMoviesResponseDTO {
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

extension WeeklyMoviesResponseDTO.BoxOfficeResultDTO.BoxOfficeListDTO {
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
