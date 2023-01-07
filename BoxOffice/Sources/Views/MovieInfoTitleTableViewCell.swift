//
//  MovieInfoTitleTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2023/01/06.
//

import UIKit

import ReactorKit

final class MovieInfoTitleTableViewCell: UITableViewCell, View {
    static let identifier = String(describing: MovieInfoTitleTableViewCell.self)
    
    private let backdropImageView: UIImageView = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 210)
        gradientLayer.opacity = 0.3
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.layer.addSublayer(gradientLayer)
        return imageView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieInfoTitleTableViewCellReactor) {
        // Action
        
        // State
        reactor.state.compactMap { $0.posterPath }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .flatMap { NetworkImageService().execute(with: $0) }
            .map { UIImage(data: $0) }
            .bind(to: self.posterImageView.rx.image)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.backdropPath }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .flatMap { NetworkImageService().execute(with: $0) }
            .map { UIImage(data: $0) }
            .bind(to: self.backdropImageView.rx.image)
            .disposed(by: disposeBag)
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
        setupBackdropImageView()
        setupPosterImageView()
    }
    
    private func setupBackdropImageView() {
        contentView.addSubview(backdropImageView)
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func setupPosterImageView() {
        backdropImageView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0),
            posterImageView.widthAnchor.constraint(equalToConstant: 120.0),
            posterImageView.heightAnchor.constraint(equalToConstant: 180.0),
        ])
    }
}
