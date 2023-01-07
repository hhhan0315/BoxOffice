//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

import ReactorKit
import RxCocoa

final class MovieListViewController: UIViewController, View {
    
    // MARK: - View Define
    
    private let dailyButton: UIButton = {
        let button = MovieListMenuButton(title: "일별")
        button.tag = KobisWeekType.daily.rawValue
        return button
    }()
    
    private let weekButton: UIButton = {
        let button = MovieListMenuButton(title: "주간")
        button.tag = KobisWeekType.week.rawValue
        return button
    }()
    
    private let weekendButton: UIButton = {
        let button = MovieListMenuButton(title: "주말")
        button.tag = KobisWeekType.weekend.rawValue
        return button
    }()
    
    private let weekdaysButton: UIButton = {
        let button = MovieListMenuButton(title: "주중")
        button.tag = KobisWeekType.weekdays.rawValue
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dailyButton, weekButton, weekendButton, weekdaysButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let collectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(140),
            heightDimension: .absolute(280)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        return activityIndicatorView
    }()
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieListReactor) {
        // Action
        self.dailyButton.rx.tap
            .map { Reactor.Action.dailyButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.weekButton.rx.tap
            .map { Reactor.Action.weekButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.weekendButton.rx.tap
            .map { Reactor.Action.weekendButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.weekdaysButton.rx.tap
            .map { Reactor.Action.weekdaysButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .compactMap { $0 }
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.buttonDidSelected }
            .distinctUntilChanged()
            .compactMap { $0 }
            .subscribe { kobisWeekType in
                self.setupButtonIsSelected(with: kobisWeekType.element)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.boxOfficeLists }
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: MovieCollectionViewCell.identifier,
                cellType: MovieCollectionViewCell.self)
            ) { index, boxOfficeList, cell in
                cell.reactor = MovieCollectionViewCellReactor(boxOfficeList: boxOfficeList)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.networkError }
            .observe(on: MainScheduler.instance)
            .distinctUntilChanged()
            .compactMap { $0 }
            .subscribe { networkError in
                self.showAlert(message: networkError.element?.rawValue)
            }
            .disposed(by: disposeBag)
        
        // View
        self.collectionView.rx.itemSelected
            .subscribe { indexPath in
                guard let item = indexPath.element?.item else {
                    return
                }
                let boxOfficeList = reactor.currentState.boxOfficeLists[item]
                let movieInfoViewController = MovieInfoViewController()
                movieInfoViewController.reactor = MovieInfoReactor(boxOfficeList: boxOfficeList)
                self.navigationController?.pushViewController(movieInfoViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "박스오피스 순위"
        navigationItem.backButtonTitle = ""
        
        setupViews()
        
        reactor?.action.onNext(.dailyButtonDidTap)
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        setupButtonStackView()
        setupCollectionView()
        setupActivityIndicatorView()
    }
    
    private func setupButtonStackView() {
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44.0),
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Helper
    
    private func setupButtonIsSelected(with kobisWeekType: KobisWeekType?) {
        let buttons = [dailyButton, weekButton, weekendButton, weekdaysButton]
        
        buttons.filter { $0.tag == kobisWeekType?.rawValue }.forEach { $0.isSelected = true }
        buttons.filter { $0.tag != kobisWeekType?.rawValue }.forEach { $0.isSelected = false }
    }
}
