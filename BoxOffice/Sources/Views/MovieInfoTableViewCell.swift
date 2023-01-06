//
//  MovieInfoTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2023/01/06.
//

import UIKit

import ReactorKit

final class MovieInfoTableViewCell: UITableViewCell, View {
    static let identifier = String(describing: MovieInfoTableViewCell.self)
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        return label
    }()
    
    private let englishNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, englishNameLabel, infoLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieInfoTableViewCellReactor) {
        // Action
        
        // State
        reactor.state.compactMap { $0.posterPath }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .flatMap({ posterPath in
                NetworkImageService().execute(with: posterPath)
            })
            .map { UIImage(data: $0) }
            .bind(to: self.posterImageView.rx.image)
            .disposed(by: disposeBag)
        
        nameLabel.text = reactor.currentState.movieName
        englishNameLabel.text = reactor.currentState.movieEnglishName
        infoLabel.text = reactor.currentState.info
    }
    
    // MARK: - View LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        setupPosterImageView()
        setupLabelStackView()
    }
    
    private func setupPosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0),
            posterImageView.widthAnchor.constraint(equalToConstant: 120.0),
            posterImageView.heightAnchor.constraint(equalToConstant: 180.0),
        ])
    }
    
    private func setupLabelStackView() {
        contentView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10.0),
            labelStackView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
        ])
    }
}
