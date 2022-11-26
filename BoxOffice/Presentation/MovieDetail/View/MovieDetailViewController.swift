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
    
    private let movieBackdropView = MovieBackdropView()
    
    private let moviePosterView = MoviePosterView()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        return activityIndicatorView
    }()
    
    // MARK: - Private Properties
    
    private let posterImageRepository: PosterImagesRepository = DefaultPosterImagesRepository(networkImageSerivce: NetworkImageService())
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
        setupMovieBackdropView()
        setupMoviePosterView()
        setupAcitivityIndicatorView()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
    }
    
    private func setupMovieBackdropView() {
        view.addSubview(movieBackdropView)
        movieBackdropView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieBackdropView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieBackdropView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieBackdropView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieBackdropView.heightAnchor.constraint(equalToConstant: 350.0),
        ])
    }
    
    private func setupMoviePosterView() {
        movieBackdropView.addSubview(moviePosterView)
        moviePosterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            moviePosterView.topAnchor.constraint(equalTo: movieBackdropView.bottomAnchor),
//            moviePosterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            moviePosterView.leadingAnchor.constraint(equalTo: movieBackdropView.leadingAnchor, constant: 16.0),
            moviePosterView.bottomAnchor.constraint(equalTo: movieBackdropView.bottomAnchor, constant: -16.0),
            moviePosterView.widthAnchor.constraint(equalToConstant: 120.0),
            moviePosterView.heightAnchor.constraint(equalToConstant: 180.0),
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
        viewModel.$item
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                self?.navigationItem.title = item?.movieName
                self?.movieBackdropView.item = item
                self?.moviePosterView.item = item
            }
            .store(in: &cancellables)
        
        viewModel.$itemDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] itemDetail in
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
