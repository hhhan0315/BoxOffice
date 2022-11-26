//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by rae on 2022/11/26.
//

import UIKit
import Combine

final class MovieDetailViewController: UIViewController {
    
    // MARK: - View Define
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        return activityIndicatorView
    }()
    
    // MARK: - Private Properties
    
    private let viewModel: MovieDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - View LifeCycle
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        bind()
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        setupNavigation()
        setupAcitivityIndicatorView()
    }
    
    private func setupNavigation() {
//        navigationItem.title =
        navigationController?.navigationBar.tintColor = .white
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
        viewModel.$item
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
//                print(item)
//                self?.tableView.reloadData()
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
