//
//  DefaultMoviesRepository.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

import RxSwift

//
//final class DefaultMoviesRepository {
//    private let networkService: NetworkService
//
//    init(networkService: NetworkService) {
//        self.networkService = networkService
//    }
//}
//
//extension DefaultMoviesRepository: MoviesRepository {
//    func fetchDailyMovieList() async throws -> [BoxOfficeList] {
//        let yesterday = Date.yesterday.toString(.yyyyMMdd)
//        let dailyMoviesRequestDTO = DailyMoviesRequestDTO(key: Secrets.kobisKey, targetDt: yesterday)
//        let dailyMoviesResponseDTO = try await networkService.request(api: KobisAPI.getDailyBoxOfficeList(dailyMoviesRequestDTO), dataType: DailyMoviesResponseDTO.self)
//        let boxOfficeLists = dailyMoviesResponseDTO.boxOfficeResult.dailyBoxOfficeList.map { $0.toDomain() }
//        return boxOfficeLists
//    }
//
//    func fetchWeeklyMovieList(with kobisWeekType: KobisWeekType) async throws -> [BoxOfficeList] {
//        let oneWeekAgo = Date.oneWeekAge.toString(.yyyyMMdd)
//        let weeklyMoviesRequestDTO = WeeklyMoviesRequestDTO(key: Secrets.kobisKey, targetDt: oneWeekAgo, weekGb: kobisWeekType)
//        let weeklyMoviesResponseDTO = try await networkService.request(api: KobisAPI.getWeeklyBoxOfficeList(weeklyMoviesRequestDTO), dataType: WeeklyMoviesResponseDTO.self)
//        let boxOfficeLists = weeklyMoviesResponseDTO.boxOfficeResult.weeklyBoxOfficeList.map { $0.toDomain() }
//        return boxOfficeLists
//    }
//
//    func fetchMovieDetail(with movieCode: String) async throws -> MovieDetail {
//        let movieDetailRequestDTO = MovieDetailRequestDTO(key: Secrets.kobisKey, movieCd: movieCode)
//        let movieDetailResponseDTO = try await networkService.request(api: KobisAPI.getMovieInfo(movieDetailRequestDTO), dataType: MovieDetailResponseDTO.self)
//        let movieDetail = movieDetailResponseDTO.movieInfoResult.movieInfo.toDomain()
//        return movieDetail
//    }
//
//    func fetchMoviePoster(with movieName: String, at openYear: String) async throws -> [Tmdb] {
//        let moviePosterRequestDTO = MoviePosterRequestDTO(apiKey: Secrets.tmdbKey, query: movieName, year: openYear)
//        let moviePosterResponseDTO = try await networkService.request(api: TmdbAPI.getSearchMovie(moviePosterRequestDTO), dataType: MoviePosterResponseDTO.self)
//        let tmdbs = moviePosterResponseDTO.results.map { $0.toDomain() }
//        return tmdbs
//    }
//}
