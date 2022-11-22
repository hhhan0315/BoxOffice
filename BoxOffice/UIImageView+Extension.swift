//
//  UIImageView+Extension.swift
//  BoxOffice
//
//  Created by rae on 2022/11/22.
//

import UIKit

extension UIImageView {
    func downloadPoster(with movie: Movie) {
        guard let posterPath = movie.tmdbInfo?.posterPath else {
            return
        }
        
        let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        
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
