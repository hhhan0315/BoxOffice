//
//  TmdbDTO.swift
//  BoxOffice
//
//  Created by rae on 2022/11/21.
//

import Foundation

struct TmdbDTO: Decodable {
    let results: [TmdbResultDTO]
}

extension TmdbDTO {
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
}
