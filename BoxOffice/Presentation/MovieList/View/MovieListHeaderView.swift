//
//  MovieListHeaderView.swift
//  BoxOffice
//
//  Created by rae on 2023/01/03.
//

import UIKit

protocol MovieListHeaderViewDelegate: AnyObject {
    func didSelect()
}

final class MovieListHeaderView: UICollectionReusableView {
    static let identifier = String(describing: MovieListHeaderView.self)
    
    weak var delegate: MovieListHeaderViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "박스오피스 순위"
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupTitleLabel()
        setupRightButton()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewDidTap))
        addGestureRecognizer(tapGesture)
        rightButton.addTarget(self, action: #selector(headerViewDidTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    private func setupRightButton() {
        addSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    @objc private func headerViewDidTap() {
        delegate?.didSelect()
    }
}
