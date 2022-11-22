//
//  UIImageView+Extension.swift
//  BoxOffice
//
//  Created by rae on 2022/11/22.
//

import UIKit

extension UIImageView {
    func downloadTmdbImage(with path: String?) {
        guard let path = path else {
            return
        }
        
        let urlString = "https://image.tmdb.org/t/p/w500\(path)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        ImageCacheManager().getImage(imageURL: url) { [weak self] data in
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
    }
}
