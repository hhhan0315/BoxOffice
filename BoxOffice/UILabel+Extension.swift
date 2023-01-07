//
//  UILabel+Extension.swift
//  BoxOffice
//
//  Created by rae on 2023/01/06.
//

import UIKit

extension UILabel {
    func attributedTitle(firstPart: String, secondPart: String?) {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 14)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart)\n", attributes: attributes)
        
        let boldAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
        attributedTitle.append(NSAttributedString(string: secondPart ?? "", attributes: boldAttributes))
        
        self.attributedText = attributedTitle
    }
}
