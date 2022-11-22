//
//  BoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by rae on 2022/11/17.
//

import UIKit

final class BoxOfficeListViewController: UIViewController {
    
    // MARK: - View Define
    
    private let dailyButton: UIButton = {
        let button = BoxOfficeListButton(title: "일별")
        button.isSelected = true
        return button
    }()
    
    private let weekButton: UIButton = {
        let button = BoxOfficeListButton(title: "주간")
        return button
    }()
    
    private let weekendButton: UIButton = {
        let button = BoxOfficeListButton(title: "주말")
        return button
    }()
    
    private let weekDaysButton: UIButton = {
        let button = BoxOfficeListButton(title: "주중")
        return button
    }()
    
    private lazy var buttons: [UIButton] = {
        let buttons: [UIButton] = [dailyButton, weekButton, weekendButton, weekDaysButton]
        return buttons
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BoxOfficeListTableViewCell.self, forCellReuseIdentifier: BoxOfficeListTableViewCell.identifier)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        return activityIndicatorView
    }()
    
    // MARK: - Private Properties
    
    private let viewModel = BoxOfficeListViewModel()
    
    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        dailyButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        weekButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        weekendButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        weekDaysButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        
        setupViews()
        
        viewModel.loadingStartClosure = {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicatorView.startAnimating()
            }
        }
        
        viewModel.loadingEndClosure = {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicatorView.stopAnimating()
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetch()
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
    
    // MARK: - User Action
    
    @objc private func buttonDidTap(_ button: UIButton) {
        guard !button.isSelected else {
            return
        }
        
        buttons.forEach { $0.isSelected = false }
        
        button.isSelected.toggle()
    }
}

// MARK: - UITableViewDataSource

extension BoxOfficeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeListTableViewCell.identifier, for: indexPath) as? BoxOfficeListTableViewCell else {
            return .init()
        }
//        print(viewModel.movies)
        cell.movies = viewModel.movies
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BoxOfficeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
