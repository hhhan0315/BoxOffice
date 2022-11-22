//
//  BoxOfficeListDTO.swift
//  BoxOffice
//
//  Created by rae on 2022/11/22.
//

import Foundation

struct BoxOfficeListDTO: Decodable {
    let rank: String // 박스오피스 순위
    let rankInten: String // 전일대비 순위의 증감분
    let rankOldAndNew: String // 랭킹에 신규진입여부
    let movieCd: String // 영화 대표코드
    let movieNm: String // 영화명 국문
    let openDt: String // 개봉일
    let audiAcc: String // 누적 관객수
}

extension BoxOfficeListDTO {
    func toDomain() -> MovieInfo {
        return .init(rank: rank,
                     rankInten: rankInten,
                     rankOldAndNew: rankOldAndNew,
                     movieCode: movieCd,
                     movieName: movieNm,
                     openDate: openDt.replacingOccurrences(of: "-", with: "."),
                     audienceAcc: Int(audiAcc)!.formattedString(with: .audienceAcc))
    }
}
