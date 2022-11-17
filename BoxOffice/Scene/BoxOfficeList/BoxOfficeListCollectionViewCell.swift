//
//  BoxOfficeListCollectionViewCell.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

final class BoxOfficeListCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: BoxOfficeListCollectionViewCell.self)
    
    // MARK: - View Define
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "개봉\n누적 관객"
        return label
    }()
    
    // MARK: - View LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        setupPosterImageView()
        setupTitleLabel()
        setupInfoLabel()
    }
    
    private func setupPosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.5)
        ])
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
        ])
    }
    
    private func setupInfoLabel() {
        contentView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
        ])
    }
}
