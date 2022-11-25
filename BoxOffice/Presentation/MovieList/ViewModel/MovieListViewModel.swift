//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation
import Combine

final class MovieListViewModel {
    private let moviesRepository: MoviesRepository = DefaultMoviesRepository(networkService: NetworkService())
    
    enum Input {
        case viewDidLoad
        case didSelectItem
        case didSelectButton
    }

    enum Output {
//        case fetchDidSucceed(items: [MovieListItemViewModel])
        case fetchDidSucceed
        case fetchDidFail(networkError: NetworkError)
    }
    
    @Published var items: [MovieListItemViewModel] = []
    
//    struct Input {
//        let viewDidLoad: AnyPublisher<Void, Never>
//    }
//
//    struct Output {
//        let items: AnyPublisher<[MovieListItemViewModel], Never>
//    }
    
//    private var items: CurrentValueSubject<[MovieListItemViewModel], Never> = .init([])
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
                self?.fetch()
            default:
                break
            }
        }
        .store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    private func fetch() {
        Task {
            do {
                let movies = try await moviesRepository.fetchDailyMovieList()
                
                for movie in movies {
                    let movieName = movie.movieName
                    let openYear = String(movie.openDate.prefix(4))
                    let tmdbs = try await moviesRepository.fetchMoviePoster(with: movieName, at: openYear)
                    let tmdb = tmdbs.first
                    
                    let item = MovieListItemViewModel(movie: movie, tmdb: tmdb)
                    items.append(item)
                }
                
                output.send(.fetchDidSucceed)
            } catch {
                if let networkError = error as? NetworkError {
                    output.send(.fetchDidFail(networkError: networkError))
                }
            }
        }
    }
}
