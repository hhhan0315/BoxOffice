//
//  BoxOfficeListTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

final class BoxOfficeListTableViewCell: UITableViewCell {
    static let identifier = String(describing: BoxOfficeListTableViewCell.self)
    
    // MARK: - View Define
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 300)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BoxOfficeListCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeListCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Internal Properties
    
    var boxOfficeLists: [BoxOfficeList] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - View LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
        collectionView.dataSource = self
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

extension BoxOfficeListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOfficeLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeListCollectionViewCell.identifier, for: indexPath) as? BoxOfficeListCollectionViewCell else {
            return .init()
        }
        let boxOfficeList = boxOfficeLists[indexPath.item]
        cell.boxOfficeList = boxOfficeList
        return cell
    }
}
