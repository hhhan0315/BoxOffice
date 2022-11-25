//
//  UIViewController+Extension.swift
//  BoxOffice
//
//  Created by rae on 2022/11/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "에러 발생",
                   message: String?) {
        guard let message = message else {
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
