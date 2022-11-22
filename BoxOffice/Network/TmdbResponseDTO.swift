//
//  TmdbResponseDTO.swift
//  BoxOffice
//
//  Created by rae on 2022/11/21.
//

import Foundation

struct TmdbResponseDTO: Decodable {
    let results: [TmdbResultDTO]
}

//extension TmdbResponseDTO {
//
//}
struct TmdbResultDTO: Decodable {
    let backdropPath: String?
    let id: Int
    let posterPath: String?
    let title: String
    let originalTitle: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case id, title, overview
    }
}

extension TmdbResultDTO {
    func toDomain() -> TmdbInfo {
        return .init(backdropPath: backdropPath,
                     posterPath: posterPath,
                     tmdbID: id,
                     overview: overview)
    }
}
