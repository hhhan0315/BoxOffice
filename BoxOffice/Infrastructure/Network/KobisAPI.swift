//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import Foundation

enum KobisWeekType: Int {
    case week = 0
    case weekend = 1
    case weekdays = 2
}

enum KobisAPI {
    case getDailyBoxOfficeList(DailyBoxOfficeListRequestDTO)
    case getWeeklyBoxOfficeList(WeeklyBoxOfficeListRequestDTO)
    case getMovieInfo(MovieInfoRequestDTO)
}

extension KobisAPI: TargetType {
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
        case let .getDailyBoxOfficeList(parameters):
            return [
                "key": parameters.key,
                "targetDt": parameters.targetDt
            ]
        case let .getWeeklyBoxOfficeList(parameters):
            return [
                "key": parameters.key,
                "targetDt": parameters.targetDt,
                "weekGb": "\(parameters.weekGb.rawValue)"
            ]
        case let .getMovieInfo(parameters):
            return [
                "key": parameters.key,
                "movieCd": parameters.movieCd
            ]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
