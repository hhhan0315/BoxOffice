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
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let posterRankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48.0, weight: .bold)
        return label
    }()
        
    private let posterNewLabelView = MoviePosterNewLabelView()
    
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
    
    // MARK: - Internal Properties
    
//    var movie: Movie? {
//        didSet {
//            guard let movie = movie else {
//                return
//            }
//            
//            let movieInfo = movie.movieInfo
//            
//            titleLabel.text = movieInfo.movieName
//            openDateLabel.text = "개봉 \(movieInfo.openDate)"
//            audienceAccLabel.text = "누적 관객수 \(movieInfo.audienceAcc)"
//            
//            posterRankLabel.text = movieInfo.rank
//            posterNewLabelView.isHidden = movieInfo.rankOldAndNew == "NEW" ? false : true
//            
//            posterImageView.downloadTmdbImage(with: movie.tmdbInfo?.posterPath)
//        }
//    }
    
    var item: MovieListItemViewModel? {
        didSet {
            guard let item = item else {
                return
            }
            
            titleLabel.text = item.movieName
            openDateLabel.text = item.openDate
            audienceAccLabel.text = item.audienceAcc
            posterRankLabel.text = item.rank
            posterNewLabelView.isHidden = !item.isNew
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
        setupPosterNewLabelView()
        
        setupTitleLabel()
        setupLabelStackView()
    }
    
    private func setupPosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 140.0),
            posterImageView.heightAnchor.constraint(equalToConstant: 210.0)
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
