//
//  MovieInfoViewController.swift
//  BoxOffice
//
//  Created by rae on 2023/01/05.
//

import UIKit

import ReactorKit

final class MovieInfoViewController: UIViewController, View {
    
    // MARK: - View Define
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorInset = .zero
        tableView.register(
            MovieInfoTitleTableViewCell.self,
            forCellReuseIdentifier: MovieInfoTitleTableViewCell.identifier
        )
        tableView.register(
            MovieInfoOverviewTableViewCell.self,
            forCellReuseIdentifier: MovieInfoOverviewTableViewCell.identifier
        )
        tableView.register(
            MovieInfoReviewTitleTableViewCell.self,
            forCellReuseIdentifier: MovieInfoReviewTitleTableViewCell.identifier
        )
        tableView.register(
            MovieInfoReviewContentTableViewCell.self,
            forCellReuseIdentifier: MovieInfoReviewContentTableViewCell.identifier
        )
        return tableView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        return activityIndicatorView
    }()
    
    // MARK: - Properties
    
    enum TableViewSection: Int, CaseIterable {
        case title = 0
        case overview = 1
        case reviewTitle = 2
        case reviewContent = 3
    }
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: MovieInfoReactor) {
        // Action
        
        // State
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .compactMap { $0 }
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.tmdb }
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.movieInfo?.movieName }
            .distinctUntilChanged()
            .compactMap { $0 }
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // View
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        
        reactor?.action.onNext(.viewDidLoad)
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupActivityIndicatorView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
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
}

// MARK: - UITableViewDataSource

extension MovieInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TableViewSection.reviewContent.rawValue {
            return self.reactor?.currentState.reviews.count ?? 0
        }
        return self.activityIndicatorView.isAnimating ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case TableViewSection.title.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieInfoTitleTableViewCell.identifier,
                for: indexPath
            ) as? MovieInfoTitleTableViewCell else {
                return .init()
            }
            
            let movieInfo = reactor?.currentState.movieInfo
            let tmdb = reactor?.currentState.tmdb
            
            cell.reactor = MovieInfoTitleTableViewCellReactor(movieInfo: movieInfo, tmdb: tmdb)
            cell.selectionStyle = .none
            
            return cell
            
        case TableViewSection.overview.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieInfoOverviewTableViewCell.identifier,
                for: indexPath
            ) as? MovieInfoOverviewTableViewCell else {
                return .init()
            }
            
            let movieInfo = reactor?.currentState.movieInfo
            let tmdb = reactor?.currentState.tmdb
            
            cell.reactor = MovieInfoOverviewTableViewCellReactor(movieInfo: movieInfo, tmdb: tmdb)
            cell.selectionStyle = .none
            cell.delegate = self
            
            return cell
            
        case TableViewSection.reviewTitle.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieInfoReviewTitleTableViewCell.identifier,
                for: indexPath
            ) as? MovieInfoReviewTitleTableViewCell else {
                return .init()
            }
            
            let movieInfo = reactor?.currentState.movieInfo
            let tmdb = reactor?.currentState.tmdb
            
            cell.reactor = MovieInfoReviewTitleTableViewCellReactor(movieInfo: movieInfo, tmdb: tmdb)
            cell.selectionStyle = .none
            cell.delegate = self
            
            return cell
            
        case TableViewSection.reviewContent.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieInfoReviewContentTableViewCell.identifier,
                for: indexPath
            ) as? MovieInfoReviewContentTableViewCell else {
                return .init()
            }
            
            cell.review = reactor?.currentState.reviews[indexPath.row]
            cell.selectionStyle = .none
            
            return cell
            
        default:
            return .init()
        }
    }
}

// MARK: - UITableViewDelegate

extension MovieInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case TableViewSection.title.rawValue:
            return 210.0
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - MovieInfoReviewTableViewCellDelegate

extension MovieInfoViewController: MovieInfoOverviewTableViewCellDelegate {
    func overviewLabelDidChange(cell: MovieInfoOverviewTableViewCell) {
        self.tableView.performBatchUpdates {
            cell.setupExpand()
        }
    }
}

// MARK: - MovieInfoReviewTableViewCellDelegate

extension MovieInfoViewController: MovieInfoReviewTitleTableViewCellDelegate {
    func reviewButtonDidTap() {
        guard let movieCode = self.reactor?.currentState.boxOfficeList?.movieCode else {
            return
        }
        
        let reviewViewController = ReviewViewController()
        reviewViewController.reactor = ReviewReactor(movieCode: movieCode)
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
}
