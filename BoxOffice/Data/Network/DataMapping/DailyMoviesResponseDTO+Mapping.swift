//
//  DailyMoviesResponseDTO+Mapping.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct DailyMoviesResponseDTO: Decodable {
    let boxOfficeResult: BoxOfficeResultDTO
}

extension DailyMoviesResponseDTO {
    struct BoxOfficeResultDTO: Decodable {
        let boxofficeType: String
        let dailyBoxOfficeList: [BoxOfficeListDTO]
        
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

extension DailyMoviesResponseDTO.BoxOfficeResultDTO.BoxOfficeListDTO {
    func toDomain() -> Movie {
        return .init(rank: rank,
                     rankInten: rankInten,
                     rankOldAndNew: rankOldAndNew,
                     movieCode: movieCd,
                     movieName: movieNm,
                     openDate: openDt,
                     audienceAcc: audiAcc)
    }
}
