//
//  TmdbAPI.swift
//  BoxOffice
//
//  Created by rae on 2022/11/19.
//

import Foundation

enum TmdbAPI: TargetType {
    case getSearchMovie(movieName: String, openYear: String)
    
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
        case let .getSearchMovie(movieName, openYear):
            return [
                "api_key": Secrets.tmdbKey,
                "language": "ko",
                "query": movieName,
                "region": "KR",
                "year": openYear,
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
