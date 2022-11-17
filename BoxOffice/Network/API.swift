//
//  API.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import Foundation

enum API {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    case getDailyBoxOfficeList(date: String)
    case getWeeklyBoxOfficeList(date: String, weekType: WeekType)
    
    var method: HTTPMethod {
        return .get
    }
    
    var baseURL: String {
        return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice"
    }
    
    var path: String {
        switch self {
        case .getDailyBoxOfficeList:
            return "/searchDailyBoxOfficeList.json"
        case .getWeeklyBoxOfficeList:
            return "/searchWeeklyBoxOfficeList.json"
        }
    }
    
    var query: [String: String]? {
        switch self {
        case let .getDailyBoxOfficeList(date):
            // 날짜 yyyymmdd 오늘보다 하루 전 기준
            return ["key": Secrets.kobisKey, "targetDt": date]
        case let .getWeeklyBoxOfficeList(date, weekType):
            return ["key": Secrets.kobisKey, "targetDt": date, "weekGb": "\(weekType.rawValue)"]
        }
    }
    
    var header: [String: String]? {
        return nil
    }
}
