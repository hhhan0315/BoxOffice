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
    
    private let moviePosterView = MoviePosterView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private let openDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    private let audienceAccLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
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
            
            moviePosterView.item = item
            titleLabel.text = item.movieName
            openDateLabel.text = item.openDate
            audienceAccLabel.text = item.audienceAcc
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
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
        
//        posterImageView.image = nil
//    }
    
    // MARK: - Layout
    
    private func setupViews() {
        setupMoviePosterView()
        setupTitleLabel()
        setupLabelStackView()
    }
    
    private func setupMoviePosterView() {
        contentView.addSubview(moviePosterView)
        moviePosterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePosterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            moviePosterView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            moviePosterView.widthAnchor.constraint(equalToConstant: 140.0),
            moviePosterView.heightAnchor.constraint(equalToConstant: 210.0)
        ])
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: moviePosterView.bottomAnchor),
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
