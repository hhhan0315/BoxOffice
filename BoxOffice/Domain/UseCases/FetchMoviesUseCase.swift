//
//  FetchMoviesUseCase.swift
//  BoxOffice
//
//  Created by rae on 2022/11/28.
//

import Foundation

protocol FetchMoviesUseCase {
    func execute(kobisWeekType: KobisWeekType) async throws -> [Movie]
}

final class DefaultFetchMoviesUseCase: FetchMoviesUseCase {
    private let moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func execute(kobisWeekType: KobisWeekType) async throws -> [Movie] {
        switch kobisWeekType {
        case .daily:
            return try await moviesRepository.fetchDailyMovieList()
        case .week, .weekend, .weekdays:
            return try await moviesRepository.fetchWeeklyMovieList(with: kobisWeekType)
        }
//        if kobisWeekType == .daily {
//            return try await moviesRepository.fetchDailyMovieList()
//        } else {
//            return try await moviesRepository.fetchWeeklyMovieList(with: kobisWeekType)
//        }
    }
}
