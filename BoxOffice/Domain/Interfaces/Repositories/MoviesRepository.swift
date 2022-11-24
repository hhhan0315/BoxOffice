//
//  MoviesRepository.swift
//  BoxOffice
//
//  Created by rae on 2022/11/23.
//

import Foundation

protocol MoviesRepository {
    func fetchDailyMovieList(with yesterday: String) async throws -> [Movie]
    func fetchWeeklyMovieList(with weekType: WeekType) async throws -> [Movie]
    func fetchMovieDetail(with movieCode: String) async throws -> [MovieDetail]
}
