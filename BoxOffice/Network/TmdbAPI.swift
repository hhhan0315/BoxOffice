//
//  TmdbAPI.swift
//  BoxOffice
//
//  Created by rae on 2022/11/19.
//

import Foundation

enum TmdbAPI: TargetType {
    case getSearchMovie(movieName: String, openYear: String)
    case getImage(path: String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var baseURL: String {
        switch self {
        case .getSearchMovie:
            return "https://api.themoviedb.org/3"
        case .getImage:
            return "https://image.tmdb.org/t/p/w500"
        }
    }
    
    var path: String {
        switch self {
        case .getSearchMovie:
            return "/search/movie"
        case .getImage(let path):
            return path
        }
    }
    
    var query: [String : String]? {
        switch self {
        case let .getSearchMovie(movieName, openYear):
            return [
                "api_key": Secrets.tmdbKey,
                "language": "ko",
                "query": movieName,
                "region": "KR",
                "year": openYear,
            ]
        case .getImage:
            return nil
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
