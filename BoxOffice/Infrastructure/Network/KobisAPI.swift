//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import Foundation

enum KobisWeekType: Int {
    case daily = -1
    case week = 0
    case weekend = 1
    case weekdays = 2
}

enum KobisAPI: TargetType {
    case getDailyBoxOfficeList(DailyMoviesRequestDTO)
    case getWeeklyBoxOfficeList(WeeklyMoviesRequestDTO)
    case getMovieInfo(MovieDetailRequestDTO)
    
    var method: HTTPMethod {
        return .get
    }
    
    var baseURL: String {
        return "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
    }
    
    var path: String {
        switch self {
        case .getDailyBoxOfficeList:
            return "/boxoffice/searchDailyBoxOfficeList.json"
        case .getWeeklyBoxOfficeList:
            return "/boxoffice/searchWeeklyBoxOfficeList.json"
        case .getMovieInfo:
            return "/movie/searchMovieInfo.json"
        }
    }
    
    var query: [String: String]? {
        switch self {
        case let .getDailyBoxOfficeList(dailyMoviesRequestDTO):
            return [
                "key": dailyMoviesRequestDTO.key,
                "targetDt": dailyMoviesRequestDTO.targetDt
            ]
        case let .getWeeklyBoxOfficeList(weeklyMoviesRequestDTO):
            return [
                "key": weeklyMoviesRequestDTO.key,
                "targetDt": weeklyMoviesRequestDTO.targetDt,
                "weekGb": "\(weeklyMoviesRequestDTO.weekGb.rawValue)"
            ]
        case let .getMovieInfo(movieDetailRequestDTO):
            return [
                "key": movieDetailRequestDTO.key,
                "movieCd": movieDetailRequestDTO.movieCd
            ]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
