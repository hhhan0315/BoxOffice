//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import Foundation

enum KobisRequestType: Int {
    case daily = -1
    case week = 0
    case weekend = 1
    case weekdays = 2
}

enum KobisAPI: TargetType {
    case getDailyBoxOfficeList(date: String)
    case getWeeklyBoxOfficeList(date: String, kobisRequestType: KobisRequestType)
    case getMovieInfo(movieCode: String)
    
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
        case let .getDailyBoxOfficeList(date):
            return [
                "key": Secrets.kobisKey,
                "targetDt": date
            ]
        case let .getWeeklyBoxOfficeList(date, kobisRequestType):
            return [
                "key": Secrets.kobisKey,
                "targetDt": date,
                "weekGb": "\(kobisRequestType.rawValue)"
            ]
        case let .getMovieInfo(movieCode):
            return [
                "key": Secrets.kobisKey,
                "movieCd": movieCode
            ]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
