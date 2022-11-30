//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit
import Combine

final class MovieListViewController: UIViewController {
    
    // MARK: - View Define
    
    private let buttonStackView = MovieListButtonStackView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        return activityIndicatorView
    }()
    
    // MARK: - Private Properties
    
    private let viewModel = MovieListViewModel(movieListUseCase: DefaultMovieListUseCase(moviesRepository: DefaultMoviesRepository(networkService: NetworkService())))
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonStackView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        bind()
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        setupNavigation()
        setupButtonStackView()
        setupTableView()
        setupAcitivityIndicatorView()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Box Office"
        navigationItem.backButtonTitle = ""
    }
    
    private func setupButtonStackView() {
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44.0),
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 8.0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
        ])
    }
    
    private func setupAcitivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$loading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loading in
                if loading {
                    self?.activityIndicatorView.startAnimating()
                } else {
                    self?.activityIndicatorView.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showAlert(message: errorMessage)
            }
            .store(in: &cancellables)
    }
}

extension MovieListViewController: MovieListButtonStackViewDelegate {
    func didSelectButton(tag: Int) {
        guard let kobisWeekType = KobisWeekType(rawValue: tag) else {
            return
        }
        viewModel.didSelectButton(with: kobisWeekType)
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else {
            return .init()
        }
        cell.items = viewModel.items
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}

// MARK: - MovieListTableViewCellDelegate

extension MovieListViewController: MovieListTableViewCellDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
//        viewModel.didSelectItem(indexPath)
        let movieListItemViewModel = viewModel.items[indexPath.item]
        let moviesRepository = DefaultMoviesRepository(networkService: NetworkService())
        let movieDetailViewModel = MovieDetailViewModel(movieListItemViewModel: movieListItemViewModel, moviesRepository: moviesRepository)
        let movieDetailViewController = MovieDetailViewController(viewModel: movieDetailViewModel)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
