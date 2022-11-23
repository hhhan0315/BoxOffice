//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by rae on 2022/11/21.
//

import Foundation

extension Date {
    enum DateFormat: String {
        case yyyyMMdd = "yyyyMMdd"
    }
    
    static var yesterday: Date! {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())
    }
    
    static var oneWeekAge: Date! {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date())
    }
    
    func toString(dateFormat: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
}
