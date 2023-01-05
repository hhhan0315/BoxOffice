////
////  MovieListUseCase.swift
////  BoxOffice
////
////  Created by rae on 2022/11/29.
////
//
//import Foundation
//
//protocol MovieListUseCase {
//    func execute(with kobisWeekType: KobisWeekType) async throws -> [Movie]
//}
//
//final class DefaultMovieListUseCase: MovieListUseCase {
//    private let moviesRepository: MoviesRepository
//
//    init(moviesRepository: MoviesRepository) {
//        self.moviesRepository = moviesRepository
//    }
//    
//    func execute(with kobisWeekType: KobisWeekType) async throws -> [Movie] {
//        let boxOfficeLists = try await fetchBoxOfficeLists(with: kobisWeekType)
//        let tmdbs = try await fetchTmdbs(with: boxOfficeLists)
//        
//        var movies: [Movie] = []
//        for (index, boxOfficeList) in boxOfficeLists.enumerated() {
//            let movie = Movie(boxOfficeList: boxOfficeList, tmdb: tmdbs[index])
//            movies.append(movie)
//        }
//        return movies
//    }
//    
//    private func fetchBoxOfficeLists(with kobisWeekType: KobisWeekType) async throws -> [BoxOfficeList] {
//        switch kobisWeekType {
//        case .daily:
//            return try await moviesRepository.fetchDailyMovieList()
//        case .week, .weekend, .weekdays:
//            return try await moviesRepository.fetchWeeklyMovieList(with: kobisWeekType)
//        }
//    }
//    
////    func fetchMovieDetails(with boxOfficeLists: [BoxOfficeList]) async throws -> [MovieDetail] {
////        var movieDetails: [MovieDetail] = []
////
////        for boxOfficeList in boxOfficeLists {
////            let result = try await moviesRepository.fetchMovieDetail(with: boxOfficeList.movieCode)
////            movieDetails.append(result)
////        }
////
////        return movieDetails
////    }
//    
//    private func fetchTmdbs(with boxOfficeLists: [BoxOfficeList]) async throws -> [Tmdb?] {
//        var tmdbs: [Tmdb?] = []
//        
//        for boxOfficeList in boxOfficeLists {
//            let result = try await moviesRepository.fetchMoviePoster(with: boxOfficeList.movieName, at: String(boxOfficeList.openDate.prefix(4)))
//            
//            if let tmdbFirst = result.first {
//                tmdbs.append(tmdbFirst)
//            } else {
//                tmdbs.append(nil)
//            }
//        }
//        
//        return tmdbs
//    }
//}
