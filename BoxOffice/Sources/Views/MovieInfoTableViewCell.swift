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
        return imageView
    }()
        
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let englishNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, englishNameLabel, infoLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieInfoTableViewCellReactor) {
        
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
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 140.0),
            posterImageView.heightAnchor.constraint(equalToConstant: 210.0),
        ])
    }
    
    private func setupLabelStackView() {
        contentView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
