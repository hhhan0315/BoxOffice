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
    
    private let viewModel = MovieListViewModel()
    private let input = PassthroughSubject<MovieListViewModel.Input, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonStackView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        bind()
        
        input.send(.viewDidLoad)
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
        navigationController?.navigationBar.prefersLargeTitles = true
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
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .fetchDidSucceed:
                    self?.tableView.reloadData()
//                    self?.tableView.reloadData()
                    break
                case .fetchDidFail(let networkError):
                    break
                }
            }
            .store(in: &cancellables)
    }
}

extension MovieListViewController: MovieListButtonStackViewDelegate {
    func didSelectButton(title: String) {
//        input.send(.didSelectButton)
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
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
