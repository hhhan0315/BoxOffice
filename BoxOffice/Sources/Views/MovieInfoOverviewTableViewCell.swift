//
//  MovieInfoOverviewTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2023/01/07.
//

import UIKit

import ReactorKit

protocol MovieInfoOverviewTableViewCellDelegate: AnyObject {
    func overviewLabelDidChange(cell: MovieInfoOverviewTableViewCell)
}

final class MovieInfoOverviewTableViewCell: UITableViewCell, View {
    static let identifier = String(describing: MovieInfoOverviewTableViewCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "줄거리"
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("더보기", for: .normal)
        button.setTitle("접기", for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, overviewLabel, moreButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Bind
    
    weak var delegate: MovieInfoOverviewTableViewCellDelegate?
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieInfoOverviewTableViewCellReactor) {
        // Action
        moreButton.rx.tap
            .subscribe { _ in
                self.delegate?.overviewLabelDidChange(cell: self)
            }
            .disposed(by: disposeBag)
        
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
        setupStackView()
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
        ])
    }
}
