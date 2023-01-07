//
//  MovieInfoContentTableViewCell.swift
//  BoxOffice
//
//  Created by rae on 2023/01/06.
//

import UIKit

import ReactorKit

final class MovieInfoContentTableViewCell: UITableViewCell, View {
    static let identifier = String(describing: MovieInfoContentTableViewCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기본정보"
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let showTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let watchGradeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let nationsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let prdtYearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [directorLabel, showTimeLabel, watchGradeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var secondLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreLabel, nationsLabel, prdtYearLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var thirdLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [actorsLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieInfoContentTableViewCellReactor) {
        // Action
        
        // State
        overviewLabel.text = reactor.currentState.overview
        directorLabel.attributedTitle(firstPart: "감독", secondPart: reactor.currentState.directorName)
        showTimeLabel.attributedTitle(firstPart: "상영 시간", secondPart: reactor.currentState.showTime)
        watchGradeLabel.attributedTitle(firstPart: "연령 등급", secondPart: reactor.currentState.watchGradeName)
        genreLabel.attributedTitle(firstPart: "장르", secondPart: reactor.currentState.genreNames)
        nationsLabel.attributedTitle(firstPart: "제작 국가", secondPart: reactor.currentState.nationNames)
        prdtYearLabel.attributedTitle(firstPart: "제작 연도", secondPart: reactor.currentState.prdtYear)
        actorsLabel.attributedTitle(firstPart: "출연", secondPart: reactor.currentState.actorNames)
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
//        setupOverviewLabel()
        setupLabelStackView()
        setupSecondLabelStackView()
        setupThirdLabelStackView()
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
    
//    private func setupOverviewLabel() {
//        contentView.addSubview(overviewLabel)
//        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
//            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
//        ])
//    }
    
    private func setupLabelStackView() {
        contentView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            labelStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
    }
    
    private func setupSecondLabelStackView() {
        contentView.addSubview(secondLabelStackView)
        secondLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabelStackView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 10.0),
            secondLabelStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            secondLabelStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
    }
    
    private func setupThirdLabelStackView() {
        contentView.addSubview(thirdLabelStackView)
        thirdLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdLabelStackView.topAnchor.constraint(equalTo: secondLabelStackView.bottomAnchor, constant: 10.0),
            thirdLabelStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            thirdLabelStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            thirdLabelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
        ])
    }
}
