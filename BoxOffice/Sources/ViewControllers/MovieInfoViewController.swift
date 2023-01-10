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
            MovieInfoReviewTableViewCell.self,
            forCellReuseIdentifier: MovieInfoReviewTableViewCell.identifier
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
//        case content = 1
        case overview = 1
        case review = 2
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
            
            return cell
            
        case TableViewSection.review.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieInfoReviewTableViewCell.identifier,
                for: indexPath
            ) as? MovieInfoReviewTableViewCell else {
                return .init()
            }
            
            let movieInfo = reactor?.currentState.movieInfo
            let tmdb = reactor?.currentState.tmdb
            
            cell.reactor = MovieInfoReviewTableViewCellReactor(movieInfo: movieInfo, tmdb: tmdb)
            cell.selectionStyle = .none
            cell.delegate = self
            
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

extension MovieInfoViewController: MovieInfoReviewTableViewCellDelegate {
    func reviewButtonDidTap() {
        // boxOfficeList의 MovieCode가 필요함
        let reviewViewController = ReviewViewController()
        reviewViewController.reactor = ReviewReactor()
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
}
