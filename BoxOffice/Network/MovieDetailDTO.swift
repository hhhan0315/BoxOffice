//
//  MovieDetailDTO.swift
//  BoxOffice
//
//  Created by rae on 2022/11/21.
//

import Foundation

struct MovieDetailDTO: Decodable {
    let movieInfoResult: MovieInfoResultDTO
}

extension MovieDetailDTO {
    struct MovieInfoResultDTO: Decodable {
        let movieInfo: MovieInfoDTO
        
        struct MovieInfoDTO: Decodable {
            let movieCd: String // 영화코드
            let movieNm: String // 영화명 국문
            let movieNmEn: String // 영화명 영문
            let showTm: String // 상영시간
            let prdtYear: String // 제작연도
            let openDt: String // 개봉일
            let genres: [GenreDTO] // 장르
            let directors: [DirectorDTO] // 감독
            let actors: [ActorDTO] // 배우
//            let companys: [CompanyDTO] // 참여 영화사
            let audits: [AuditDTO] // 심의정보
        }
        
        struct GenreDTO: Decodable {
            let genreNm: String
        }
        
        struct DirectorDTO: Decodable {
            let peopleNm: String
        }
        
        struct ActorDTO: Decodable {
            let peopleNm: String
        }
        
//        struct CompanyDTO: Decodable {
//            let companyNm, companyPartNm: String
//        }
        
        struct AuditDTO: Decodable {
            let watchGradeNm: String
        }
    }
}
