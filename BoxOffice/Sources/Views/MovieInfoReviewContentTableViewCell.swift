//
//  MovieInfoReviewContentTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2023/01/13.
//

import UIKit

final class MovieInfoReviewContentTableViewCell: UITableViewCell {
    static let identifier = String(describing: MovieInfoReviewContentTableViewCell.self)
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var review: Review? {
        didSet {
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
        setupUsernameLabel()
        setupContentLabel()
    }
    
    private func setupUsernameLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])
    }
    
    private func setupContentLabel() {
        contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10.0),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            contentLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
        ])
    }
}
