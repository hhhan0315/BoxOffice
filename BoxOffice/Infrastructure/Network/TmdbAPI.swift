//
//  TmdbAPI.swift
//  BoxOffice
//
//  Created by rae on 2022/11/19.
//

import Foundation

enum TmdbAPI {
    case getSearchMovie(MovieTmdbRequestDTO)
}

extension TmdbAPI: TargetType {
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
        case let .getSearchMovie(parameters):
            return [
                "api_key": parameters.apiKey,
                "language": parameters.language,
                "query": parameters.query,
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
