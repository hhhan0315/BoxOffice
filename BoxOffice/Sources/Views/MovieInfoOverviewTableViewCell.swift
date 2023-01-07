//
//  MovieInfoOverviewTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2023/01/07.
//

import UIKit

import ReactorKit

final class MovieInfoOverviewTableViewCell: UITableViewCell, View {
    static let identifier = String(describing: MovieInfoOverviewTableViewCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "줄거리"
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieInfoOverviewTableViewCellReactor) {
        // Action
        
        // State
        overviewLabel.text = reactor.currentState.overview
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
        setupTitleLabel()
        setupOverviewLabel()
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
        ])
    }
    
    private func setupOverviewLabel() {
        contentView.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
        ])
    }
}
