//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation
import Combine

protocol MovieListViewModelInput {
    func viewDidLoad()
    func didSelectButton(_ kobisRequestType: KobisRequestType)
    func didSelectItem(_ indexPath: IndexPath)
}

protocol MovieListViewModelOutput {
    var items: [MovieListItemViewModel] { get }
    var loading: Bool { get }
    var errorMessage: String? { get }
}

final class MovieListViewModel: MovieListViewModelInput, MovieListViewModelOutput {
    private let moviesRepository: MoviesRepository = DefaultMoviesRepository(networkService: NetworkService())
    
    // MARK: - Input
    
    func viewDidLoad() {
        fetchMovies(with: .daily)
    }
    
    func didSelectButton(_ kobisRequestType: KobisRequestType) {
        fetchMovies(with: kobisRequestType)
    }
    
    func didSelectItem(_ indexPath: IndexPath) {
//        print(items[indexPath.item])
        // MovieDetailVC 전환
    }
    
    // MARK: - Output

    @Published var items: [MovieListItemViewModel] = []
    @Published var loading: Bool = false
    @Published var errorMessage: String? = nil
    
    private func fetchMovies(with kobisRequestType: KobisRequestType) {
        Task {
            do {
                items.removeAll()
                loading = true
                
                var movies: [Movie] = []
                
                if kobisRequestType == .daily {
                    movies = try await moviesRepository.fetchDailyMovieList()
                } else {
                    movies = try await moviesRepository.fetchWeeklyMovieList(with: kobisRequestType)
                }
                
                var tempItems: [MovieListItemViewModel] = []
                
                for movie in movies {
                    let movieName = movie.movieName
                    let openYear = String(movie.openDate.prefix(4))
                    let tmdbs = try await moviesRepository.fetchMoviePoster(with: movieName, at: openYear)
                    let tmdb = tmdbs.first
                    
                    let item = MovieListItemViewModel(movie: movie, tmdb: tmdb)
                    tempItems.append(item)
                }
                
                loading = false
                items.append(contentsOf: tempItems)
            } catch {
                if let networkError = error as? NetworkError {
                    errorMessage = networkError.rawValue
                }
            }
        }
    }
}
