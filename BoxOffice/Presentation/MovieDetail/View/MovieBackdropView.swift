//
//  MovieBackdropView.swift
//  BoxOffice
//
//  Created by rae on 2022/11/26.
//

import UIKit

final class MovieBackdropView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.opacity = 0.7
        return imageView
    }()
    
    private let posterImageRepository: PosterImagesRepository = DefaultPosterImagesRepository(networkImageSerivce: NetworkImageService())
    
    var item: MovieListItemViewModel? {
        didSet {
            guard let item = item else {
                return
            }
            
            Task {
                guard let backdropPath = item.backdropPath else {
                    return
                }
                let imageData = try await posterImageRepository.fetchImage(with: backdropPath)
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = UIImage(data: imageData)
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupImageView()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
}
