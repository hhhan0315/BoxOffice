//
//  MoviePosterResponseDTO+Mapping.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

struct MoviePosterResponseDTO: Decodable {
    let results: [ResultDTO]
    
    struct ResultDTO: Decodable {
        let backdropPath: String?
        let posterPath: String?
        let id: Int
        let overview: String
        
        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case posterPath = "poster_path"
            case id, overview
        }
    }
}

extension MoviePosterResponseDTO.ResultDTO {
    func toDomain() -> Tmdb {
        return .init(backdropPath: backdropPath,
                     posterPath: posterPath,
                     id: id,
                     overview: overview)
    }
}
