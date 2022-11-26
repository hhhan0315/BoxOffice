//
//  MovieListTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

protocol MovieListTableViewCellDelegate: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

final class MovieListTableViewCell: UITableViewCell {
    static let identifier = String(describing: MovieListTableViewCell.self)
    
    // MARK: - View Define
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 300)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
        
    // MARK: - Internal Properties
    
    weak var delegate: MovieListTableViewCellDelegate?
    
    var items: [MovieListItemViewModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - View LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension MovieListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else {
            return .init()
        }
        let item = items[indexPath.item]
        cell.item = item
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MovieListTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
}
