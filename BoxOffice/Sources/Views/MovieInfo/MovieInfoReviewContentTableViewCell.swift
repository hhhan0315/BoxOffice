//
//  MovieInfoReviewContentTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2023/01/13.
//

import UIKit

import Cosmos

final class MovieInfoReviewContentTableViewCell: UITableViewCell {
    static let identifier = String(describing: MovieInfoReviewContentTableViewCell.self)
    
    private let cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.fillMode = .half
        cosmosView.settings.starSize = 15
        return cosmosView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cosmosView, usernameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        return label
    }()
    
    var review: Review? {
        didSet {
            cosmosView.rating = review?.rating ?? 0
            usernameLabel.text = review?.username
            contentLabel.text = review?.content
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupHeaderStackView()
        setupContentLabel()
    }
    
    private func setupHeaderStackView() {
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cosmosView.widthAnchor.constraint(equalToConstant: 120.0)
        ])
        
        contentView.addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            headerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])
    }
        
    private func setupContentLabel() {
        contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10.0),
            contentLabel.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            contentLabel.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor),
        ])
    }
}
