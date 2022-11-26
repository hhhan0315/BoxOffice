//
//  MoviePosterView.swift
//  BoxOffice
//
//  Created by rae on 2022/11/26.
//

import UIKit

final class MoviePosterView: UIView {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let posterRankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48.0, weight: .bold)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        return label
    }()
    
    private let posterRankIntenLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .semibold)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        return label
    }()
        
    private let posterNewLabelView = MoviePosterNewLabelView()
    
    private let posterImageRepository: PosterImagesRepository = DefaultPosterImagesRepository(networkImageSerivce: NetworkImageService())
    
    var item: MovieListItemViewModel? {
        didSet {
            guard let item = item else {
                return
            }
            
            posterRankLabel.text = item.rank
            posterRankIntenLabel.textColor = item.isRankIntenUp ? .systemRed : .systemBlue
            posterRankIntenLabel.text = item.rankInten
            posterNewLabelView.isHidden = !item.isNew
            
            Task {
                guard let posterPath = item.posterPath else {
                    return
                }
                let imageData = try await posterImageRepository.fetchImage(with: posterPath)
                DispatchQueue.main.async { [weak self] in
                    self?.posterImageView.image = UIImage(data: imageData)
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
        setupPosterImageView()
        setupPosterRankLabel()
        setupPosterRankIntenLabel()
        setupPosterNewLabelView()
    }
    
    private func setupPosterImageView() {
        addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupPosterRankLabel() {
        posterImageView.addSubview(posterRankLabel)
        posterRankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterRankLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 4.0),
            posterRankLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
        ])
    }
    
    private func setupPosterRankIntenLabel() {
        posterImageView.addSubview(posterRankIntenLabel)
        posterRankIntenLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterRankIntenLabel.centerYAnchor.constraint(equalTo: posterRankLabel.centerYAnchor),
            posterRankIntenLabel.leadingAnchor.constraint(equalTo: posterRankLabel.trailingAnchor),
        ])
    }
    
    private func setupPosterNewLabelView() {
        posterImageView.addSubview(posterNewLabelView)
        posterNewLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterNewLabelView.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 4.0),
            posterNewLabelView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -4.0),
        ])
    }
}
