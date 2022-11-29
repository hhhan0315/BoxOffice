//
//  FetchTmdbUseCase.swift
//  BoxOffice
//
//  Created by rae on 2022/11/28.
//

import Foundation

protocol FetchTmdbUseCase {
    func execute(movies: [Movie]) async throws -> [Tmdb]
}

final class DefaultFetchTmdbUseCase: FetchTmdbUseCase {
    private let moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func execute(movies: [Movie]) async throws -> [Tmdb] {
        var tmdbs: [Tmdb] = []
                
        for movie in movies {
            let result = try await moviesRepository.fetchMoviePoster(with: movie.movieName, at: String(movie.openDate.prefix(4)))
            if let tmdbFirst = result.first {
                tmdbs.append(tmdbFirst)
            }
        }
        
        return tmdbs
    }
}
