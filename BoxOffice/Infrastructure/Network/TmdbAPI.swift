//
//  TmdbAPI.swift
//  BoxOffice
//
//  Created by rae on 2022/11/19.
//

import Foundation

enum TmdbAPI: TargetType {
    case getSearchMovie(MoviePosterRequestDTO)
    
    var method: HTTPMethod {
        return .get
    }
    
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var path: String {
        switch self {
        case .getSearchMovie:
            return "/search/movie"
        }
    }
    
    var query: [String : String]? {
        switch self {
        case let .getSearchMovie(moviePosterRequestDTO):
            return [
                "api_key": moviePosterRequestDTO.apiKey,
                "language": moviePosterRequestDTO.language,
                "query": moviePosterRequestDTO.query,
                "region": moviePosterRequestDTO.region,
                "year": moviePosterRequestDTO.year,
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
