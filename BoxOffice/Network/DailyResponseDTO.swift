//
//  DailyResponseDTO.swift
//  BoxOffice
//
//  Created by rae on 2022/11/21.
//

import Foundation

struct DailyResponseDTO: Decodable {
    let boxOfficeResult: BoxOfficeResultDTO
}

extension DailyResponseDTO {
    struct BoxOfficeResultDTO: Decodable {
        let dailyBoxOfficeList: [BoxOfficeListDTO]
    }
}
