//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/26.
//

import Foundation

protocol MovieDetailViewModelInput {
    func viewDidLoad()
}

protocol MovieDetailViewModelOutput {
    var item: MovieListItemViewModel? { get }
    var itemDetail: MovieDetailItemViewModel? { get }
    var loading: Bool { get }
    var errorMessage: String? { get }
}

final class MovieDetailViewModel: MovieDetailViewModelInput, MovieDetailViewModelOutput {
    private let movieListItemViewModel: MovieListItemViewModel
    private let moviesRepository: MoviesRepository
    
    init(movieListItemViewModel: MovieListItemViewModel, moviesRepository: MoviesRepository) {
        self.movieListItemViewModel = movieListItemViewModel
        self.moviesRepository = moviesRepository
    }
    
    // MARK: - Input
    
    func viewDidLoad() {
        fetchMovieDetail(with: movieListItemViewModel.movieCode)
    }
    
    // MARK: - Output
    
    @Published var item: MovieListItemViewModel? = nil
    @Published var itemDetail: MovieDetailItemViewModel? = nil
    @Published var loading: Bool = false
    @Published var errorMessage: String? = nil
    
    private func fetchMovieDetail(with movieCode: String) {
        Task {
            do {                
                self.loading = true
                
                let movieDetail = try await moviesRepository.fetchMovieDetail(with: movieCode)
                let itemDetail = MovieDetailItemViewModel(movieDetail: movieDetail)
                
                self.loading = false
                self.item = movieListItemViewModel
                self.itemDetail = itemDetail
            } catch {
                if let networkError = error as? NetworkError {
                    errorMessage = networkError.rawValue
                }
            }
        }
    }
}
