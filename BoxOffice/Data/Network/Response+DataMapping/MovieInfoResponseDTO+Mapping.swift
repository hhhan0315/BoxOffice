//
//  MovieInfoResponseDTO+Mapping.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct MovieInfoResponseDTO: Decodable {
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
            let nations: [NationDTO]
            let genres: [GenreDTO]
            let directors: [DirectorDTO]
            let actors: [ActorDTO]
            let companys: [CompanyDTO]
            let audits: [AuditDTO]
            
            struct NationDTO: Decodable {
                let nationNm: String
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
            
            struct CompanyDTO: Decodable {
                let companyNm, companyPartNm: String
            }
            
            struct AuditDTO: Decodable {
                let watchGradeNm: String
            }
        }
    }
}

extension MovieInfoResponseDTO.MovieInfoResultDTO.MovieInfoDTO {
    func toDomain() -> MovieInfo {
        return .init(movieName: movieNm,
                     movieNameEnglish: movieNmEn,
                     showTime: showTm,
                     prdtYear: prdtYear,
                     openDate: openDt,
                     nationNames: nations.map { $0.nationNm },
                     genreNames: genres.map { $0.genreNm },
                     directorNames: directors.map { $0.peopleNm },
                     actorNames: actors.map { $0.peopleNm },
                     watchGradeNames: audits.map { $0.watchGradeNm } )
    }
}
