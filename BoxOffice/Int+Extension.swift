//
//  Int+Extension.swift
//  BoxOffice
//
//  Created by rae on 2022/11/22.
//

import Foundation

extension Int {
    enum IntFormat {
        case audienceAcc
    }
    
    func formattedString(with format: IntFormat) -> String {
        switch format {
        case .audienceAcc:
            if self < 10000 {
                return "\(self)"
            } else {
                return "\(self / 10_000)만"
            }
        }
    }
}
