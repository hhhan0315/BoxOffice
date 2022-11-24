//
//  DefaultMoviesRepository.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

final class DefaultMoviesRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultMoviesRepository: MoviesRepository {
    func fetchDailyMovieList(with yesterday: String) async throws -> [Movie] {
        <#code#>
    }
    
    func fetchWeeklyMovieList(with weekType: WeekType) async throws -> [Movie] {
        <#code#>
    }
    
    func fetchMovieDetail(with movieCode: String) async throws -> [MovieDetail] {
        <#code#>
    }
}
