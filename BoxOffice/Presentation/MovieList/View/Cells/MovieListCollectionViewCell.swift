//
//  MovieListCollectionViewCell.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: MovieListCollectionViewCell.self)
    
    // MARK: - View Define
        
    private let posterImageView: UIImageView = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7 , 1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 140, height: 210)
        
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.addSublayer(gradientLayer)
        return imageView
    }()
    
    private let posterRankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 42.0, weight: .bold)
//        label.layer.shadowColor = UIColor.black.cgColor
//        label.layer.shadowRadius = 2.0
//        label.layer.shadowOpacity = 0.8
//        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        return label
    }()
    
    private let posterRankIntenLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
//        label.layer.shadowColor = UIColor.black.cgColor
//        label.layer.shadowRadius = 2.0
//        label.layer.shadowOpacity = 0.8
//        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        return label
    }()
        
    private let posterNewLabelView = MoviePosterNewLabelView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        return label
    }()
    
    private let openDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    private let audienceAccLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [openDateLabel, audienceAccLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Private Properties
    
    private let posterImageRepository: PosterImagesRepository = DefaultPosterImagesRepository(networkImageSerivce: NetworkImageService())
    
    // MARK: - Internal Properties
    
    var item: MovieListItemViewModel? {
        didSet {
            guard let item = item else {
                return
            }
            
            titleLabel.text = item.movieName
            openDateLabel.text = item.openDate
            audienceAccLabel.text = item.audienceAcc
            
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
    
    // MARK: - View LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        setupPosterImageView()
        setupPosterRankLabel()
        setupPosterRankIntenLabel()
        setupPosterNewLabelView()
        
        setupTitleLabel()
//        setupLabelStackView()
    }
    
    private func setupPosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 140), // 65 130
            posterImageView.heightAnchor.constraint(equalToConstant: 210), // 65  195
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
//            posterRankIntenLabel.centerYAnchor.constraint(equalTo: posterRankLabel.centerYAnchor),
            posterRankIntenLabel.leadingAnchor.constraint(equalTo: posterRankLabel.trailingAnchor),
            posterRankIntenLabel.bottomAnchor.constraint(equalTo: posterRankLabel.bottomAnchor, constant: -6.0),
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
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40.0),
        ])
    }
    
    private func setupLabelStackView() {
        contentView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
