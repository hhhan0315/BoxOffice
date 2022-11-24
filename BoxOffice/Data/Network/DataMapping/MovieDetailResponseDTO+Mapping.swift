//
//  MovieDetailResponseDTO+Mapping.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct MovieDetailResponseDTO: Decodable {
    let movieInfoResult: MovieInfoResultDTO
    
    struct MovieInfoResultDTO: Decodable {
        let movieInfo: MovieInfoDTO
        
        struct MovieInfoDTO: Decodable {
            let movieCd: String
            let movieNm: String
            let movieNmEn: String
            let showTm: String
            let prdtYear: String
            let openDt: String
            let genres: [GenreDTO]
            let directors: [DirectorDTO]
            let actors: [ActorDTO]
            let companys: [CompanyDTO]
            let audits: [AuditDTO]
            
            struct GenreDTO: Decodable {
                let genreNm: String
            }
            
            struct DirectorDTO: Decodable {
                let peopleNm: String
            }
            
            struct ActorDTO: Decodable {
                let peopleNm: String
            }
            
            struct CompanyDTO: Decodable {
                let companyNm, companyPartNm: String
            }
            
            struct AuditDTO: Decodable {
                let watchGradeNm: String
            }
        }
    }
}

extension MovieDetailResponseDTO.MovieInfoResultDTO.MovieInfoDTO {
    func toDomain() -> MovieDetail {
        return .init(showTime: showTm,
                     genres: genres.map { $0.genreNm },
                     directors: directors.map { $0.peopleNm },
                     actors: actors.map { $0.peopleNm },
                     watchGrade: audits.map { $0.watchGradeNm }
        )
    }
}
