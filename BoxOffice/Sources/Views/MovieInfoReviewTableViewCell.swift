//
//  MovieInfoReviewTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2023/01/07.
//

import UIKit

import ReactorKit

protocol MovieInfoReviewTableViewCellDelegate: AnyObject {
    func reviewButtonDidTap()
}

final class MovieInfoReviewTableViewCell: UITableViewCell, View {
    static let identifier = String(describing: MovieInfoReviewTableViewCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰"
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        return label
    }()
    
    private let reviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("리뷰 작성", for: .normal)
        return button
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, reviewButton])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Bind
    
    weak var delegate: MovieInfoReviewTableViewCellDelegate?
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieInfoReviewTableViewCellReactor) {
        // Action
        reviewButton.rx.tap
            .subscribe { _ in
                self.delegate?.reviewButtonDidTap()
            }
            .disposed(by: disposeBag)
        
        // State
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
        setupHeaderStackView()
        setupTableView()
    }
    
    private func setupHeaderStackView() {
        contentView.addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            headerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
        ])
    }
    
    private func setupTableView() {
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            tableView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
        ])
    }
}
