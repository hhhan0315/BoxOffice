//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

import ReactorKit
import RxSwift
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
            .subscribe { kobisWeekType in
                self.setupButtonIsSelected(with: kobisWeekType.element)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.movieCellReactors }
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: MovieCollectionViewCell.identifier,
                cellType: MovieCollectionViewCell.self)
            ) { index, cellReactor, cell in
                cell.reactor = cellReactor
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
//                let movieInfoViewController = MovieInfoViewController()
//                self.navigationController?.pushViewController(movieInfoViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "박스오피스 순위"
        
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

// MARK: - UITableViewDataSource

//extension MovieListViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else {
//            return .init()
//        }
//
//        let item = viewModel.items[indexPath.item]
//        cell.item = item
//        return cell
//    }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieListHeaderView.identifier, for: indexPath) as? MovieListHeaderView else {
//                return .init()
//            }
//            headerView.isHidden = activityIndicatorView.isAnimating ? true : false
//            headerView.delegate = self
//            return headerView
//        default:
//            return .init()
//        }
//    }
//}

// MARK: - MovieListHeaderViewDelegate

//extension MovieListViewController: MovieListHeaderViewDelegate {
//    func didSelect() {
//        print(#function)
//    }
//}
