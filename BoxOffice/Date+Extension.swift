//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by rae on 2022/11/21.
//

import Foundation

extension Date {
    static var yesterday: Date! {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())
    }
    
//    func toString(_ for)
}
