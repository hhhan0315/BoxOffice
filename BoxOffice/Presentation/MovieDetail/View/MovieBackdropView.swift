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
        return imageView
    }()
    
    private let blackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.opacity = 0.3
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
        setupBlackImageView()
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
    
    private func setupBlackImageView() {
        addSubview(blackImageView)
        blackImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blackImageView.topAnchor.constraint(equalTo: topAnchor),
            blackImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blackImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blackImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
