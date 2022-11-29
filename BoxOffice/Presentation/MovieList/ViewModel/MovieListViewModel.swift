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
    func didSelectButton(with kobisWeekType: KobisWeekType)
//    func didSelectItem(_ indexPath: IndexPath)
}

protocol MovieListViewModelOutput {
    var items: [MovieListItemViewModel] { get }
    var loading: Bool { get }
    var errorMessage: String? { get }
}

final class MovieListViewModel: MovieListViewModelInput, MovieListViewModelOutput {
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private let fetchTmdbUseCase: FetchTmdbUseCase
    
    init(fetchMoviesUseCase: FetchMoviesUseCase, fetchTmdbUseCase: FetchTmdbUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.fetchTmdbUseCase = fetchTmdbUseCase
    }
    
    // MARK: - Input
    
    func viewDidLoad() {
        fetchMovies(with: .daily)
    }
    
    func didSelectButton(with kobisWeekType: KobisWeekType) {
        fetchMovies(with: kobisWeekType)
    }
    
//    func didSelectItem(_ indexPath: IndexPath) {
//        print(items[indexPath.item])
        // MovieDetailVC 전환
//    }
    
    // MARK: - Output
    
    @Published var items: [MovieListItemViewModel] = []
    @Published var loading: Bool = false
    @Published var errorMessage: String? = nil
    
    private func fetchMovies(with kobisWeekType: KobisWeekType) {
        items.removeAll()
        loading = true
        
        Task {
            do {
                let movies = try await fetchMoviesUseCase.execute(kobisWeekType: kobisWeekType)
                var items = movies.map { MovieListItemViewModel(movie: $0) }
                
                loading = false
                self.items = items
                
                let tmdbs = try await fetchTmdbUseCase.execute(movies: movies)
                for (index, tmdb) in tmdbs.enumerated() {
                    items[index].tmdb = tmdb
                }
                self.items = items
            } catch {
                if let networkError = error as? NetworkError {
                    errorMessage = networkError.rawValue
                }
            }
        }
    }
}
