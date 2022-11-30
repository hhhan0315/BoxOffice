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
    private let movieListUseCase: MovieListUseCase
    
    init(movieListUseCase: MovieListUseCase) {
        self.movieListUseCase = movieListUseCase
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
    
    private var movies: [Movie] = []
    
    private func fetchMovies(with kobisWeekType: KobisWeekType) {
        Task {
            do {
                items.removeAll()
                loading = true
                
                let movies = try await movieListUseCase.execute(with: kobisWeekType)
                let items = movies.map { MovieListItemViewModel(movie: $0) }
                
                self.items = items
                self.movies = movies
                loading = false
            } catch {
                if let networkError = error as? NetworkError {
                    self.errorMessage = networkError.rawValue
                }
            }
        }
    }
}
