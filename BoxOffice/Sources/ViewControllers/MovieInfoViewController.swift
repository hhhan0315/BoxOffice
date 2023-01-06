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
        let tableView = UITableView()
        return tableView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        return activityIndicatorView
    }()
    
    // MARK: - Properties
    
    enum TableViewSection: Int, CaseIterable {
        case info = 0
        //        case review = 1
        //        case overview = 2
        //        case comments = 3
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
        
        // View
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
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
        switch section {
            //        case TableViewSection.comments.rawValue:
            //            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case TableViewSection.info.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath) as? MovieInfoTableViewCell else {
                return .init()
            }
            
            return cell
        default:
            return .init()
        }
    }
}
