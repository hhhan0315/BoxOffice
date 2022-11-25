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
    func fetchDailyMovieList() async throws -> [Movie] {
        let yesterday = Date.yesterday.toString(.yyyyMMdd)
        let dailyMoviesResponseDTO = try await networkService.request(api: KobisAPI.getDailyBoxOfficeList(date: yesterday), dataType: DailyMoviesResponseDTO.self)
        let movies = dailyMoviesResponseDTO.boxOfficeResult.dailyBoxOfficeList.map { $0.toDomain() }
        return movies
    }
    
    func fetchWeeklyMovieList(with kobisRequestType: KobisRequestType) async throws -> [Movie] {
        let oneWeekAgo = Date.oneWeekAge.toString(.yyyyMMdd)
        let weeklyMoviesResponseDTO = try await networkService.request(api: KobisAPI.getWeeklyBoxOfficeList(date: oneWeekAgo, kobisRequestType: kobisRequestType), dataType: WeeklyMoviesResponseDTO.self)
        let movies = weeklyMoviesResponseDTO.boxOfficeResult.weeklyBoxOfficeList.map { $0.toDomain() }
        return movies
    }
    
    func fetchMovieDetail(with movieCode: String) async throws -> MovieDetail {
        let movieDetailResponseDTO = try await networkService.request(api: KobisAPI.getMovieInfo(movieCode: movieCode), dataType: MovieDetailResponseDTO.self)
        let movieDetail = movieDetailResponseDTO.movieInfoResult.movieInfo.toDomain()
        return movieDetail
    }
    
    func fetchMoviePoster(with movieName: String, at openYear: String) async throws -> [Tmdb] {
        let moviePosterResponseDTO = try await networkService.request(api: TmdbAPI.getSearchMovie(movieName: movieName, openYear: openYear), dataType: MoviePosterResponseDTO.self)
        let tmdbs = moviePosterResponseDTO.results.map { $0.toDomain() }
        return tmdbs
    }
}
