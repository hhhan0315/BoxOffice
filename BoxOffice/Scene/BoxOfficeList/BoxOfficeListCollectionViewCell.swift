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
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    // MARK: - Internal Properties
    
    var boxOfficeList: BoxOfficeList? {
        didSet {
            guard let boxOfficeList = boxOfficeList else {
                return
            }
            
            titleLabel.text = boxOfficeList.movieName
            infoLabel.text = "\(boxOfficeList.openDate) 개봉\n누적관객 \(boxOfficeList.audienceAcc)"
//            
//            guard let posterPath = boxOfficeList.posterPath else {
//                return
//            }
//            
//            URLSession.shared.dataTask(with: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!) { data, response, error in
//                guard let data = data else {
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    self.posterImageView.image = UIImage(data: data)
//                }
//            }.resume()
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
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 140.0),
            posterImageView.heightAnchor.constraint(equalToConstant: 210.0)
        ])
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func setupInfoLabel() {
        contentView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
