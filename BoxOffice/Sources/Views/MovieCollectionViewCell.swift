//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

import ReactorKit
import RxSwift

final class MovieCollectionViewCell: UICollectionViewCell, View {
    static let identifier = String(describing: MovieCollectionViewCell.self)
    
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
        imageView.backgroundColor = .black
        imageView.layer.addSublayer(gradientLayer)
        return imageView
    }()
    
    private let posterRankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 42.0, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let posterRankIntenLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
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
        label.textColor = .systemGray
        return label
    }()
    
    private let audienceAccLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, openDateLabel, audienceAccLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieCollectionViewCellReactor) {
        self.posterRankLabel.text = reactor.currentState.rank
        self.posterRankIntenLabel.text = reactor.currentState.rankInten
        self.posterRankIntenLabel.textColor = reactor.currentState.isRankIntenUp ? .systemRed : .systemBlue
        self.posterNewLabelView.isHidden = !reactor.currentState.isNew
        
        self.titleLabel.text = reactor.currentState.movieName
        self.openDateLabel.text = reactor.currentState.openDate
        self.audienceAccLabel.text = reactor.currentState.audienceAcc
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
        setupLabelStackView()
    }
    
    private func setupPosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 140),
            posterImageView.heightAnchor.constraint(equalToConstant: 210),
        ])
    }
    
    private func setupPosterRankLabel() {
        posterImageView.addSubview(posterRankLabel)
        posterRankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterRankLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 8.0),
            posterRankLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
        ])
    }
    
    private func setupPosterRankIntenLabel() {
        posterImageView.addSubview(posterRankIntenLabel)
        posterRankIntenLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterRankIntenLabel.leadingAnchor.constraint(equalTo: posterRankLabel.trailingAnchor),
            posterRankIntenLabel.bottomAnchor.constraint(equalTo: posterRankLabel.bottomAnchor, constant: -6.0),
        ])
    }
    
    private func setupPosterNewLabelView() {
        posterImageView.addSubview(posterNewLabelView)
        posterNewLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterNewLabelView.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 8.0),
            posterNewLabelView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -8.0),
        ])
    }
    
    private func setupLabelStackView() {
        contentView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
