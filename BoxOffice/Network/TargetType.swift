//
//  TargetType.swift
//  BoxOffice
//
//  Created by rae on 2022/11/19.
//

import Foundation

protocol TargetType {
    var method: HTTPMethod { get }
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var query: [String: String]? { get }
    
    var headers: [String: String]? { get }
}
