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
        
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let movieNameEnglishLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieNameLabel, movieNameEnglishLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
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
        setupPosterImageView()
        setupLabelStackView()
        
        setupAcitivityIndicatorView()
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
    }
    
    private func setupMovieBackdropView() {
        view.addSubview(movieBackdropView)
        movieBackdropView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieBackdropView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieBackdropView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieBackdropView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieBackdropView.heightAnchor.constraint(equalToConstant: 320.0),
        ])
    }
    
    private func setupPosterImageView() {
        movieBackdropView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: movieBackdropView.leadingAnchor, constant: 16.0),
            posterImageView.bottomAnchor.constraint(equalTo: movieBackdropView.bottomAnchor, constant: -16.0),
            posterImageView.widthAnchor.constraint(equalToConstant: 120.0),
            posterImageView.heightAnchor.constraint(equalToConstant: 180.0),
        ])
    }
    
    private func setupLabelStackView() {
        movieBackdropView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16.0),
            labelStackView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: movieBackdropView.trailingAnchor, constant: -16.0),
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
                self?.movieBackdropView.item = item
//                self?.movieNameLabel.text = item?.movieName
                
//                Task {
//                    guard let posterPath = item?.posterPath else {
//                        return
//                    }
//                    guard let imageData = try await self?.posterImageRepository.fetchImage(with: posterPath) else {
//                        return
//                    }
//                    DispatchQueue.main.async { [weak self] in
//                        self?.posterImageView.image = UIImage(data: imageData)
//                    }
//                }
            }
            .store(in: &cancellables)
        
        viewModel.$itemDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] itemDetail in
                self?.movieNameEnglishLabel.text = itemDetail?.movieNameEnglishAndPrdtYear
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
