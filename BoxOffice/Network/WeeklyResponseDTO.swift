//
//  WeeklyResponseDTO.swift
//  BoxOffice
//
//  Created by rae on 2022/11/21.
//

import Foundation

struct WeeklyResponseDTO: Decodable {
    let boxOfficeResult: BoxOfficeResultDTO
}

extension WeeklyResponseDTO {
    struct BoxOfficeResultDTO: Decodable {
        let weeklyBoxOfficeList: [BoxOfficeListDTO]
    }
}
